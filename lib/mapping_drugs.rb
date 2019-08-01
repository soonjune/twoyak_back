require 'json'

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

def match_drug(drug, counts)
    #presets
    ingr_names = ['아스피린과립','아스피린리신','아스피린알루미늄','아스피린제피세립','아스피린장용피입자','아스피린장용과립','아스피린장용펠렛','아스피린','주사용아스피린리신90%','아스피린제피세립(아세틸살리실산제피세립)']
    codes = [857,858,859,860,861,862,863,864,865,866]
    a = JSON.parse(drug.ingr_kor_name).preset_comma.include_any?(ingr_names)
    # 이름 검증할 때 필요
    # if a.empty?
    #     puts drug.name
    # else
    #     a.each { |val|
    #         counts[val] += 1
    #     }
    # end
    # 데이터 넣는 코드
    if a.empty?
        puts drug.name + drug.ingr_kor_name
        puts "0.아스피린과립 //1.아스피린리신 // 2.아스피린알루미늄 // 3.아스피린제피세립 // 4.아스피린장용피입자 // 5.아스피린장용과립 // 6.아스피린장용펠렛 // 7.아스피린 // 8.주사용아스피린리신90% // 9.아스피린제피세립(아세틸살리실산제피세립)"
        puts "번호 입력해주세요"
        index = gets.chomp
        res = 0
        #확인 후 입력
        while res != 1 do
            puts "#{index} #{ingr_names[index.to_i]} 가 맞습니까? (yes:1 no:0)"
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
        new_map.drug_ingr_id = 5
        new_map.dur_ingr_id = codes[index.to_i]
        new_map.save
        
    else
        new_map = DrugAssociation.new
        new_map.drug_id = drug.id
        new_map.drug_ingr_id = 5
        new_map.dur_ingr_id = codes[ingr_names.index(a[0])]
        new_map.save
    end
end

#이부프로펜
# puts "1.이부프로펜, 2.이부프로펜제피세립, 3.이부프로펜아르기닌, 4.이부프로펜나트륨이수화물, 5.이부프로펜리신"

search = ActiveRecord::Base.connection.execute("SELECT * FROM drugs WHERE ingr_kor_name like '%아스피린%';")
counts = Hash.new(0)

search.each { |mysql_drug|
    drug = Drug.find(mysql_drug[0])
    match_drug(drug, counts)
    # if nested_hash_value(drug.package_insert, "INGR_KOR_NAME") == "이부프로펜"
    #     puts drug.name
    # end
}
#이름 출력해보기
puts counts
puts search.count

# puts nested_hash_value(a, "INGR_KOR_NAME")

