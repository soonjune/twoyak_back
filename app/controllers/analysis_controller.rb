class AnalysisController < ApplicationController
  def interaction
    require 'set'
    require 'json'

    @search_terms = []
    interactions1 = Set.new
    interactions2 = Set.new
    @cautions = Set.new
    @alerts =[]

    a =  JSON.parse(params[:search])
    puts a[0]['query1']['search_type']
    i = 0
    a.each do |term|
      i += 1
      #검색 약물 이름 넣기
      puts term["query#{i}"]["search_term"]
      @search_terms << term["query#{i}"]["search_term"]
      #검색 타입이 의약품 이름인 경우
      if(term["query#{i}"]["search_type"] == 'drug_name')
        #의약품 이름으로 찾기
        drug_found = Drug.where(item_name: term["query#{i}"]["search_term"]).first
        if (!drug_found.nil?)
          drug_found.dur_ingrs.each do |dur|
          #First_ingr에 해당하는 interaction 넣기
          query1 = "SELECT * FROM interactions 
          WHERE JSON_SEARCH(first_ingr, 'all', '%""#{dur.dur_code}""%') is not NULL"
          interaction1s_found = Interaction.find_by_sql(query1)
          if (!interaction1s_found.nil?)
            interaction1s_found.each do |int1|
            interactions1.add(int1)
            end
          end
          #Second_ingr에 해당하는 interaction 넣기
          query2 = "SELECT * FROM interactions 
          WHERE JSON_SEARCH(first_ingr, 'all', '%""#{dur.dur_code}""%') is not NULL"
          interaction2s_found = Interaction.find_by_sql(query2)
          if (!interaction2s_found.nil?)
            interaction2s_found.each do |int2|
            interactions2.add(int2)
            end
          end
        end
      end
      elsif(term["query#{i}"]["search_type"] == 'drug_ingr_kor')
        #의약품 성분명(한글)으로 찾기
        search = "SELECT * FROM dur_ingrs WHERE ingr_kor_name = '" + term["query#{i}"][:search_term] + "' OR related_ingr_kor_name = '" + term["query#{i}"][:search_term] + "'"
        ingr_found = DurIngr.find_by_sql(search)
        ingr_found.each do |dur|
          #First_ingr에 해당하는 interaction 넣기
          query1 = "SELECT * FROM interactions 
          WHERE JSON_SEARCH(first_ingr, 'all', '%""#{dur.dur_code}""%') is not NULL"
          interaction1s_found = Interaction.find_by_sql(query1)
          interaction1s_found.each do |int1|
            interactions1.add(int1)
          end
          #Second_ingr에 해당하는 interaction 넣기
          query2 = "SELECT * FROM interactions 
          WHERE JSON_SEARCH(second_ingr, 'all', '%""#{dur.dur_code}""%') is not NULL"
          interaction2s_found = Interaction.find_by_sql(query2)
          interaction2s_found.each do |int2|
            interactions2.add(int2)
          end
        end
      elsif(term["query#{i}"]["search_type"] == 'drug_ingr_eng')
        #의약품 성분명(영어)으로 찾기
        ingr_found = DurIngr.where(ingr_eng_name: term["query#{i}"]["search_term"])
        ingr_found.each do |dur|
          #First_ingr에 해당하는 interaction 넣기
          query1 = "SELECT * FROM interactions 
          WHERE JSON_SEARCH(first_ingr, 'all', '%""#{dur.dur_code}""%') is not NULL"
          interaction1s_found = Interaction.find_by_sql(query1)
          interaction1s_found.each do |int1|
            interactions1.add(int1)
          end
          #Second_ingr에 해당하는 interaction 넣기
          query2 = "SELECT * FROM interactions 
          WHERE JSON_SEARCH(second_ingr, 'all', '%""#{dur.dur_code}""%') is not NULL"
          interaction2s_found = Interaction.find_by_sql(query2)
          interaction2s_found.each do |int2|
            interactions2.add(int2)
          end
        end
      elsif(term["query#{i}"]["search_type"] == 'sup')
        #건강기능식품 이름으로 찾기
        sup_found = Supplement.where(product_name: term["query#{i}"]["search_term"])
        if(!sup_found.supplement_ingrs.nil?)
          sup_found.supplement_ingrs.each do |sup|
            #First_ingr에 해당하는 interaction 넣기
            query1 = "SELECT * FROM interactions 
            WHERE JSON_SEARCH(first_ingr, 'all', '%""#{sup}""%') is not NULL"
            interaction1s_found = Interaction.find_by_sql(query1)
            interaction1s_found.each do |int1|
              interactions1.add(int1)
            end
            #Second_ingr에 해당하는 interaction 넣기
            query2 = "SELECT * FROM interactions 
            WHERE JSON_SEARCH(second_ingr, 'all', '%""#{sup}""%') is not NULL"
            interaction2s_found = Interaction.find_by_sql(query2)
            interaction2s_found.each do |int2|
              interactions2.add(int2)
            end
          end
        end
      elsif(term["query#{i}"]["search_type"] == 'sup_ingr')
        #건강기능식품 이름으로 찾기
        ingr_found = SupplementIngr.where(ingr_name: term["query#{i}"]["search_term"])
        ingr_found.each do |ingr|
          #First_ingr에 해당하는 interaction 넣기
          query1 = "SELECT * FROM interactions 
          WHERE JSON_SEARCH(first_ingr, 'all', '%""#{ingr.ingr_name}""%') is not NULL"
          interaction1s_found = Interaction.find_by_sql(query1)
          interaction1s_found.each do |int1|
            interactions1.add(int1)
          end
          #Second_ingr에 해당하는 interaction 넣기
          query2 = "SELECT * FROM interactions 
          WHERE JSON_SEARCH(second_ingr, 'all', '%""#{ingr.ingr_name}""%') is not NULL"
          interaction2s_found = Interaction.find_by_sql(query2)
          interaction2s_found.each do |int2|
            interactions2.add(int2)
          end
        end
      end
    end
      #경고 보여주기
      @alerts = if interactions1.intersect?(interactions2)
        interactions1 & interactions2
      end
      #주의해야할 사항들 보여주기
      @cautions = (interactions1 | interactions2) - @alerts
      
      render json: @alerts
  end
end
