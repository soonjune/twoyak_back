class User::AnalysisController < ApplicationController
  before_action :set_code, only: [:get]

  def get
    require 'json'
    require 'http'

    response = HTTP.get("https://www.hira.or.kr/rg/dur/getRestListJson.do?medcCd=#{@codes}")
    rest = JSON.parse(response)["data"]
    @result = Hash.new
    @result["data"] = JSON.parse(response)["data"]
    # #병용금기
    # @result["interactions"] = rest["A"]
    # #연령금기
    # @result["age"] = rest["B"]
    # #임부금기
    # @result["pregnancy"] = rest["C"]
    # #사용(급여)중지
    # @result["stop_usage"] = rest["D"]
    # #동일성분중복
    # @result["same_ingr"] = rest["G"]
    # #효능군중복
    # @result["duplicate"] = rest["F"]
    # #용량주의
    # @result["dosage"] = rest["I"]
    # #투여기간주의
    # @result["period"] = rest["J"]
    # #노인주의
    # @result["elder"] = rest["L"]



    @result["Excluded"] = @excluded
    render json: @result

  end

  # def single_drug
  #   require 'json'
  #   require 'http'

  #   select_drug =  Drug.find(:drug_id)
  #   select_code = select_drug.package_insert['DRB_ITEM']['EDI_CODE'] ? select_drug.package_insert['DRB_ITEM']['EDI_CODE'] : nil

  #   response = HTTP.get("https://www.hira.or.kr/rg/dur/getRestListJson.do?medcCd=#{@codes}")
  #   rest = JSON.parse(response)["data"]["rest"]

  #   @result = Hash.new
  #   #병용금기
  #   @result["interactions"] = rest["A"]
  #   #연령금기
  #   @result["age"] = rest["B"]
  #   #임부금기
  #   @result["pregnancy"] = rest["C"]
  #   #사용(급여)중지
  #   @result["stop_usage"] = rest["D"]
  #   #동일성분중복
  #   @result["same_ingr"] = rest["G"]
  #   #효능군중복
  #   @result["duplicate"] = rest["F"]
  #   #용량주의
  #   @result["dosage"] = rest["I"]
  #   #투여기간주의
  #   @result["period"] = rest["J"]
  #   #노인주의
  #   @result["elder"] = rest["L"]



  #   @result["Excluded"] = @excluded
  #   render json: @result
  # end

  def interaction
    require 'set'
    require 'json'

    @search_terms = []
    interactions1 = Set.new
    ingr1 = []
    interactions2 = Set.new
    ingr2 = []
    cautions = []
    alerts =[]
    
    searches =  JSON.parse(params[:search])
    for i in 1..searches.length
      term = searches["query#{i}"]
      search_term = term["search_term"]

      #검색 타입이 의약품 이름인 경우
      if term["search_type"] == 'drug_name'
        #검색어 넣기
        searched = if search_term
          Drug.search(search_term, fields: [name: :exact])
        end
        @search_terms << "#{search_term}의 성분: #{JSON.parse(searched.first.ingr_kor_name).join(",")}"
        searched.first.dur_ingrs.each { |ingr|
            Interaction.search(ingr.dur_code, fields: [{first_ingr: :exact}]).each { |interaction|
              interactions1.add(interaction)
            }  
            Interaction.search(ingr.dur_code, fields: [{second_ingr: :exact}]).each { |interaction|
              interactions2.add(interaction)
            }
        }
      #검색 타입이 의약품 성분(한글)인 경우
      elsif term["search_type"] == 'drug_ingr_kor'
        searched = if search_term
          DurIngr.search(search_term, fields: [{ingr_kor_name: :exact}, {related_ingr_kor_name: :exact}])
        end
        puts "성분 찾기"
        @search_terms << "#{search_term}"
        Interaction.search(searched.first.dur_code, fields: [{first_ingr: :exact}]).each { |interaction|
          interactions1.add(interaction)
        }  
        Interaction.search(searched.first.dur_code, fields: [{second_ingr: :exact}]).each { |interaction|
          interactions2.add(interaction)
        }

      #검색 타입이 의약품 성분(영문)인 경우
      elsif term["search_type"] == 'drug_ingr_eng'
        searched = if search_term
          DurIngr.search(search_term, fields: [{ingr_eng_name: :exact}, {ingr_eng_name_lo: :exact}])
        end
        @search_terms << "#{search_term}"
        #약물이 검색되지 않는 경우
        if searched.first.nil?
          searched = Drug.search(search_term, fields: [:ingr_eng_name])
          searched.first.dur_ingrs.each { |ingr|
            Interaction.search(ingr.dur_code, fields: [{first_ingr: :exact}]).each { |interaction|
              interactions1.add(interaction)
            }  
            Interaction.search(ingr.dur_code, fields: [{second_ingr: :exact}]).each { |interaction|
              interactions2.add(interaction)
            }
          }
        else
        Interaction.search(searched.first.dur_code, fields: [{first_ingr: :exact}]).each { |interaction|
          interactions1.add(interaction)
        }  
        Interaction.search(searched.first.dur_code, fields: [{second_ingr: :exact}]).each { |interaction|
          interactions2.add(interaction)
        }
      end
      
      #검색 타입이 건강기능식품 제품인 경우
      elsif term["search_type"] == 'sup'
        searched = if search_term
          Supplement.search(search_term, fields: [{name: :exact}])
        end
        @search_terms << "#{search_term}의 주요성분"
        searched.first.supplement_ingrs.each { |supingr|
            ingr = supingr.ingr_name
            if(ingr.include?("홍삼"))
              ingr = "인삼"
              Interaction.search(ingr.strip, fields: [:first_ingr]).each { |interaction|
                interactions1.add(interaction)
              }
              Interaction.search(ingr.strip, fields: [:second_ingr]).each { |interaction|
                interactions2.add(interaction)
              }
            elsif((ingr.include?("오메가") && ingr.include?("오메가")) || ingr.downcase.include?("epa") || ingr.downcase.include?("dha"))
              ingr = "오메가-3 지방산(EPA & DHA)"
              Interaction.search(ingr.strip, fields: [:first_ingr]).each { |interaction|
                interactions1.add(interaction)
              }
              Interaction.search(ingr.strip, fields: [:second_ingr]).each { |interaction|
                interactions2.add(interaction)
              }
            else
              ["인삼", "프로바이오틱스", "알로에", "밀크씨슬", "감마리놀렌산", "당귀", "돌외잎", "대두", "카르니틴", "녹차", "키토산", "키토올리고당", "스피루리나", "글루코사민", "석류", "가시오가피", "클로렐라", "공액리놀레산", "코엔자임Q10", "은행", "쏘팔메토추출물", "포스파티딜세린", "크랜베리", "감초"]. each { |test| 
                if(searched.first.ingredients.include?(test))
                  ingr = test
                end
                Interaction.search(ingr, fields: [:first_ingr]).each { |interaction|
                  interactions1.add(interaction)
                }
                Interaction.search(ingr, fields: [:second_ingr]).each { |interaction|
                  interactions2.add(interaction)
                }
              }
            end
        }
      
      #검색 타입이 건강기능식품 성분인 경우
      elsif term["search_type"] == 'sup_ingr'
        searched = if search_term
          SupplementIngr.search(search_term, fields: [:ingr_name])
        end
        @search_terms << "#{search_term}"
        searched.each { |ingr|
            Interaction.search(ingr, fields: [:first_ingr]).each { |interaction|
              interactions1.add(interaction)
            }
            Interaction.search(ingr, fields: [:second_ingr]).each { |interaction|
              interactions2.add(interaction)
            }
        }
    end
  end
      #경고 보여주기
      alerts = if interactions1.intersect?(interactions2)
        interactions1 & interactions2
      end



      #주의해야할 사항들 보여주기
      if(alerts.nil?)
        cautions = interactions1 | interactions2
        puts cautions
      else
        cautions = (interactions1 | interactions2) - alerts
      #DUR 코드 성분 이름으로 변환

        # 성분명 바꾸는 법 1
        alerts = alerts.to_json
        alerts_hash = JSON.parse(alerts)
        name_alerts = []
        if(!alerts.nil?)
            alerts_hash.each { |alert|
              inserts = Hash.new
              inserts["id"] = alert["id"]
              inserts["interaction_type"] = alert["interaction_type"]
              #첫번째 성분
              if(alert["first_ingr"].class != Array)
                first = JSON.parse(alert["first_ingr"])
              else
                first = alert["first_ingr"]
              end
                inserts["first_ingr"] = first.map! {|dur|
                  if(inserts["id"] == 256)
                    dur = "isosorbide dinitrate"
                  elsif(inserts["id"] == 257)
                    dur = "isosorbide mononitrate"
                  elsif(/D00\d{4}/ =~ dur)
                    dur = DurIngr.search(dur, fields: [{dur_code: :exact}]).first.ingr_eng_name
                  else
                    dur = dur
                  end
                }
        
              #두번째 성분
              if(alert["second_ingr"].class != Array)
                second = JSON.parse(alert["second_ingr"])
              else
                second = alert["second_ingr"]
              end
                inserts["second_ingr"] = second.map! {|dur| 
                  if(/D00\d{4}/ =~ dur)
                    dur = DurIngr.search(dur, fields: [{dur_code: :exact}]).first.ingr_eng_name
                  else
                    dur = dur
                  end
                }
                
              inserts["review"] = alert["review"]
              inserts["note"] = alert["note"]
              inserts["more_info"] = alert["more_info"]
              name_alerts << inserts
            }
        end
      end
      #성분명 바꾸는 법 2
      cautions = cautions.to_json
      cautions_hash = JSON.parse(cautions)
      name_cautions = []
      if(!cautions.nil?)
          cautions_hash.each { |alert|
            inserts = Hash.new
            inserts["id"] = alert["id"]
            inserts["interaction_type"] = alert["interaction_type"]
            #첫번째 성분
            if(alert["first_ingr"].class != Array)
              first = JSON.parse(alert["first_ingr"])
            else
              first = alert["first_ingr"]
            end
              inserts["first_ingr"] = first.map! {|dur| 
                if(/D00\d{4}/ =~ dur)
                  dur = DurIngr.search(dur, fields: [{dur_code: :exact}]).first.ingr_eng_name
                else
                  dur = dur
                end
              }
       
            #두번째 성분
            if(alert["second_ingr"].class != Array)
              second = JSON.parse(alert["second_ingr"])
            else
              second = alert["second_ingr"]
            end
              inserts["second_ingr"] = second.map! {|dur| 
                if(/D00\d{4}/ =~ dur)
                  dur = DurIngr.search(dur, fields: [{dur_code: :exact}]).first.ingr_eng_name
                else
                  dur = dur
                end
              }
              
            inserts["review"] = alert["review"]
            inserts["note"] = alert["note"]
            inserts["more_info"] = alert["more_info"]
            name_cautions << inserts
          }
      end


      hash_1 = {:search_terms => @search_terms}
      hash_2 = {:alerts => name_alerts}
      hash_3 = {:cautions => name_cautions}
      
      combine = hash_1.merge(hash_2)
      @result = combine.merge(hash_3)

      render json: @result
  end

  private

    def set_code
      require 'json'
      @codes = ""
      @excluded = []
      user_info_current_drugs = CurrentDrug.where(user_info_id: params[:user_info_id])

      user_info_current_drugs.each do |current_drug|
        select_drug =  Drug.find(current_drug.current_drug_id)
        if select_drug.package_insert.nil?
          @excluded << select_drug.name
        else
          select_code = select_drug.package_insert['DRB_ITEM']['EDI_CODE'] ? select_drug.package_insert['DRB_ITEM']['EDI_CODE'] : nil
          if select_code.nil?
            bar_code = select_drug.package_insert['DRB_ITEM']['BAR_CODE'] ?  select_drug.package_insert['DRB_ITEM']['BAR_CODE'][3..-2] : nil
            if !bar_code.nil?
              @codes << bar_code + ";"
            end
          else
            edi_code = select_code + "0"
            @codes << edi_code + ";"
            edi_code = select_code + "1"
            @codes << edi_code + ";"
          end
        end
      end
    end
end


