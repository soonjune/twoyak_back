class Drug < ApplicationRecord
    require 'json'
      
      def kor_map(enumerable)
        result = []
        if(!enumerable.nil?)
            JSON.parse(enumerable).each do |element| 
            element.nil? ? next : result.push(*(element))
            end
        end
        result
      end

      def eng_map(enumerable)
        if(!enumerable.nil?)
            a = JSON.parse(enumerable)
        end
        a
      end

    has_and_belongs_to_many :dur_ingrs
    has_one :drug_imprint

    searchkick language: "korean", word_middle: [:item_name, :ingr_kor_name, :ingr_eng_name], synonyms: [["Aspirin", "acetylsalicylic acid"]]
    def search_data
        {
            name: item_name,
            ingr_kor_name: kor_map(ingr_kor_name),
            ingr_eng_name: eng_map(ingr_eng_name),
            name_tagged: [["감기약 => 아세트아미노펜"],["감기약 => 이부프로펜"],["감기약 => 아스피린"], ["항히스타민", "항히스타민제"], ["항히스타민 => 클로르페니라민"], ["항히스타민 => 클레마스틴"], ["항히스타민 => 트리프롤리딘"], ["항히스타민 => 디펜히드라민"], ["항히스타민 => 메퀴타진"], ["항히스타민 => 독시라민"], ["항히스타민 => 세티리진"], ["항히스타민 => 아젤라스틴"], ["항히스타민 => 로라타딘"], ["항히스타민 => 에바스틴"], ["항히스타민 => 에피나스틴"], ["항히스타민 => 펙소페나딘"], ["항히스타민 => 레보세티리진"], ["항히스타민 => 데스로라타딘"]].map(&:value).join(" ")
    
        }
    end
end
