require 'test_helper'

class DrugImprintsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @drug_imprint = drug_imprints(:one)
  end

  test "should get index" do
    get drug_imprints_url, as: :json
    assert_response :success
  end

  test "should create drug_imprint" do
    assert_difference('DrugImprint.count') do
      post drug_imprints_url, params: { drug_imprint: { color_back: @drug_imprint.color_back, color_front: @drug_imprint.color_front, description: @drug_imprint.description, dosage_form: @drug_imprint.dosage_form, drug_id: @drug_imprint.drug_id, drug_image: @drug_imprint.drug_image, drug_shape: @drug_imprint.drug_shape, item_name: @drug_imprint.item_name, length_long: @drug_imprint.length_long, length_short: @drug_imprint.length_short, line_back: @drug_imprint.line_back, line_front: @drug_imprint.line_front, mark_code_back: @drug_imprint.mark_code_back, mark_code_front: @drug_imprint.mark_code_front, mark_content_back: @drug_imprint.mark_content_back, mark_content_front: @drug_imprint.mark_content_front, mark_img_back: @drug_imprint.mark_img_back, mark_img_front: @drug_imprint.mark_img_front, print_back: @drug_imprint.print_back, print_front: @drug_imprint.print_front, thickness: @drug_imprint.thickness } }, as: :json
    end

    assert_response 201
  end

  test "should show drug_imprint" do
    get drug_imprint_url(@drug_imprint), as: :json
    assert_response :success
  end

  test "should update drug_imprint" do
    patch drug_imprint_url(@drug_imprint), params: { drug_imprint: { color_back: @drug_imprint.color_back, color_front: @drug_imprint.color_front, description: @drug_imprint.description, dosage_form: @drug_imprint.dosage_form, drug_id: @drug_imprint.drug_id, drug_image: @drug_imprint.drug_image, drug_shape: @drug_imprint.drug_shape, item_name: @drug_imprint.item_name, length_long: @drug_imprint.length_long, length_short: @drug_imprint.length_short, line_back: @drug_imprint.line_back, line_front: @drug_imprint.line_front, mark_code_back: @drug_imprint.mark_code_back, mark_code_front: @drug_imprint.mark_code_front, mark_content_back: @drug_imprint.mark_content_back, mark_content_front: @drug_imprint.mark_content_front, mark_img_back: @drug_imprint.mark_img_back, mark_img_front: @drug_imprint.mark_img_front, print_back: @drug_imprint.print_back, print_front: @drug_imprint.print_front, thickness: @drug_imprint.thickness } }, as: :json
    assert_response 200
  end

  test "should destroy drug_imprint" do
    assert_difference('DrugImprint.count', -1) do
      delete drug_imprint_url(@drug_imprint), as: :json
    end

    assert_response 204
  end
end
