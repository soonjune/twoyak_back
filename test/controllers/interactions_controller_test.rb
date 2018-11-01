require 'test_helper'

class InteractionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @interaction = interactions(:one)
  end

  test "should get index" do
    get interactions_url, as: :json
    assert_response :success
  end

  test "should create interaction" do
    assert_difference('Interaction.count') do
      post interactions_url, params: { interaction: { first_ingr: @interaction.first_ingr, interaction_type: @interaction.interaction_type, more_info: @interaction.more_info, note: @interaction.note, review: @interaction.review, second_ingr: @interaction.second_ingr } }, as: :json
    end

    assert_response 201
  end

  test "should show interaction" do
    get interaction_url(@interaction), as: :json
    assert_response :success
  end

  test "should update interaction" do
    patch interaction_url(@interaction), params: { interaction: { first_ingr: @interaction.first_ingr, interaction_type: @interaction.interaction_type, more_info: @interaction.more_info, note: @interaction.note, review: @interaction.review, second_ingr: @interaction.second_ingr } }, as: :json
    assert_response 200
  end

  test "should destroy interaction" do
    assert_difference('Interaction.count', -1) do
      delete interaction_url(@interaction), as: :json
    end

    assert_response 204
  end
end
