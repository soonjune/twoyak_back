require 'test_helper'

class DrugAssociationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @drug_association = drug_associations(:one)
  end

  test "should get index" do
    get drug_associations_url, as: :json
    assert_response :success
  end

  test "should create drug_association" do
    assert_difference('DrugAssociation.count') do
      post drug_associations_url, params: { drug_association: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show drug_association" do
    get drug_association_url(@drug_association), as: :json
    assert_response :success
  end

  test "should update drug_association" do
    patch drug_association_url(@drug_association), params: { drug_association: {  } }, as: :json
    assert_response 200
  end

  test "should destroy drug_association" do
    assert_difference('DrugAssociation.count', -1) do
      delete drug_association_url(@drug_association), as: :json
    end

    assert_response 204
  end
end
