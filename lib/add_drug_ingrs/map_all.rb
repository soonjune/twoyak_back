require 'json'

#사전에 채울 것들 goto search as well
def drug_ingr_id
    34
end

search_name = "네오마이신"
eng_ingr_name = 'fluticasone'
ingr_names = [search_name]
#유사성분 존재시 goto 유사성분 in match_drugs
codes = []
ingr_search = ActiveRecord::Base.connection.execute("SELECT * FROM dur_ingrs WHERE ingr_eng_name = '#{eng_ingr_name}'")
puts "영문명으로 검색한 dur_ingr 결과 #{ingr_search}"
if ingr_search.count != 0
    ingr_names = []
    ingr_search.each { |mysql_dur|
        ingr_names << mysql_dur[5]
        codes << mysql_dur[0]
    }
puts ingr_names.to_s
puts codes.to_s
end

#drug_ingr_id 정확한지 확인
if search_name != DrugIngr.find(drug_ingr_id).name
    puts "dur_ingr_id 확인요망"
    return
else
    puts "#{DrugIngr.find(drug_ingr_id).name} 시작"
end

def nested_hash_value(obj,key)
    if obj.respond_to?(:key?) && obj.key?(key)
      obj[key]
    elsif obj.respond_to?(:each)
      r = nil
      obj.find{ |*a| r=nested_hash_value(a.last,key) }
      r
    end
end

class Array
    def include_any?(array)
        result = []
        array.any? {|i| 
            if self.uniq.include? i
            result << i
            end
            }
        return result
    end
end

class Array
    def preset_comma
        result = [] 
        self.each { |elem|
            result.push(*(elem.split(',').map(&:strip)))
        }
        return result
    end
end

def match_drug(drug, counts, ingr_names, codes)
    #presets
    a = JSON.parse(drug.ingr_kor_name).preset_comma.include_any?(ingr_names)
    #경구용인지 확인
    if !drug.hira_main_ingr_code.nil?
        if (hira_main_ingr_code[-3] == C)
            return
        end
        creams = ["LN", "LT", "EM", "AW", "SR", "EL", "LE", "OS", "OO", "CM", "OM", "PA"]
        if creams.include?(drug.hira_main_ingr_code[-2..-1])
            return
        end
    end
    if (drug.name.include?("크림")) || (drug.name.include?("연고")) || (drug.name.include?("로션"))
        return
    end
    
    # 이름 검증할 때 필요
    if a.empty?
        puts drug.name
    else
        a.each { |val|
            counts[val] += 1
        }
    end
    # 데이터 넣는 코드
    if a.empty?
        puts drug.name + drug.ingr_kor_name
        puts ingr_names.to_s
        # 유사 성분 skip
        # if drug.ingr_kor_name.include?("메틸프레드니솔론") || drug.ingr_kor_name.include?("메칠프레드니솔론")
        #     puts "메틸프로드니솔론 skip"
        #     return
        # end
        puts "번호 입력해주세요(첫번째 원소가 0부터 시작) skip은 넘어가기"
        index = gets.chomp
        if index == "skip"
            return
        end
        res = 0
        #확인 후 입력
        while res != 1 do
            puts "#{index} #{ingr_names[index.to_i]} 가 맞습니까? (yes:1 no:0, skip:skip)"
            res = gets.chomp.to_i
            if res == 1
                break
            else
                puts "번호 다시 입력해주세요"
                index = gets.chomp
            end
        end
        new_map = DrugAssociation.new
        new_map.drug_id = drug.id
        new_map.drug_ingr_id = drug_ingr_id
        # dur code 없는 경우 작동 안되게
        if !codes.empty?
            new_map.dur_ingr_id = codes[index.to_i]
        end
        puts new_map.save
        
    else
        new_map = DrugAssociation.new
        new_map.drug_id = drug.id
        new_map.drug_ingr_id = drug_ingr_id
        # dur code 없는 경우 비워둘것
        if !codes.empty?
            new_map.dur_ingr_id = codes[ingr_names.index(a[0])]
        end
        puts new_map.save
    end
end

#이부프로펜
# puts "1.이부프로펜, 2.이부프로펜제피세립, 3.이부프로펜아르기닌, 4.이부프로펜나트륨이수화물, 5.이부프로펜리신"
search = ActiveRecord::Base.connection.execute("SELECT * FROM drugs WHERE ingr_kor_name like '%#{search_name}%'")
counts = Hash.new(0)

search.each { |mysql_drug|
    drug = Drug.find(mysql_drug[0])
    match_drug(drug, counts, ingr_names, codes)
    # if nested_hash_value(drug.package_insert, "INGR_KOR_NAME") == "이부프로펜"
    #     puts drug.name
    # end
}
#이름 출력해보기
puts counts
puts search.count

# puts nested_hash_value(a, "INGR_KOR_NAME")

