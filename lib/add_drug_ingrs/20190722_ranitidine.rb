require 'json'

@insert = DrugIngr.new
#성분 국문명
@insert.name = "라니티딘"
#성분 영문명
@insert.name_eng = "RaNITIdine"

description = {
    basics: {
      class: '소화성궤양용제(H2 차단제)',
      definition: '위벽에서 위산의 분비를 자극하는 히스타민이라는 물질의 수용체에 대한 작용을 억제하여 위산을 감소시키는 위장약입니다.',
      caution: ['검은색의 타르질 변이나 커피색의 구토를 하게 되면 궤양출혈일 수 있기 때문에 즉시 약사나 의사에게 알리도록 합니다.', '소화성궤양의 경우 재발 방지를 위해 중도에 복약을 중지하지 않도록 합니다.', '임산부, 수유부가 H2 차단제를 복용할 경우에는 주의를 요한다. 환자가 임신하고 있을 경우나 수유부의 경우는 주치의와 상담하도록 합니다', '장기간 복용할 경우에는 정기적으로 간기능, 신기능 검사를 하도록 복약지도를 하도록 합니다']
    },
    name: '라니티딘(잔탁®)',
    definition: '위산의 과다분비로 인한 위궤양, 식도염, 속쓰림 등의 치료에 사용된다.',
    target_symptoms: '적응증(치료 효과가 기대되는 증상): 위산과다, 속쓰림, 신트림, 소화성 궤양, 졸링거-엘리슨 증후근',
    upsides: nil,
    downsides: nil,
    danger: nil
      }
@insert.description = description.to_json
#Lexi-Drugs Multinational atc_code
@insert.atc_code = ["A02BA02"]
@insert.save




