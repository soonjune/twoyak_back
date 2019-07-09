class User::PastDrugsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_past_drug, :search_id, only: [:create, :show, :destroy]
  before_action :update_past_drug, only: [:update]
  before_action :id_to_modify, only: [:update, :destroy]

  # GET /past_drugs
  def index
    @past_drugs = PastDrug.all

    render json: @past_drugs
  end

  # GET /past_drugs/1
  def show
    @result = @past_drug.as_json
    my_reviews = current_user.drug_reviews
    @result.map { |drug|
      drug_found = Drug.find(drug["past_drug_id"])
      drug_reviews = drug_found.reviews
      review_efficacies = drug_reviews.pluck(:efficacy)
      drug["drug_name"] = drug_found.name
      drug["drug_rating"] = review_efficacies.empty? ? "평가 없음" : (review_efficacies.sum / review_efficacies.count)
      drug["dur_info"] = drug_found.dur_info
      drug["my_review"] = reviews.where(user_id: current_user.id)
    }
    render json: @result
  end

  # POST /past_drugs
  def create
    if @past_drug << Drug.find(@search_id) 
      set_time_memo = PastDrug.order("created_at").where(user_info_id: params[:user_info_id], past_drug_id: @search_id).last
      set_time_memo.update(from: params[:from], to: params[:to] ? params[:to] : Time.zone.now, memo: params[:memo], when: params[:whern], how: params[:how])
      render json: @past_drug.pluck(:id, :name), status: :created
    else
      render json: @past_drug.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /past_drugs/1
  def update
    if @past_drug.update(@past_drug_params)
      render json: @past_drug
    else
      render json: @past_drug.errors, status: :unprocessable_entity
    end
  end

  # DELETE /past_drugs/1
  def destroy
    PastDrug.find(@id_to_modify).delete
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_past_drug
      if current_user.has_role? "admin"
        @past_drug = UserInfo.find(params[:user_info_id]).past_drugs
      else
        if current_user.user_info_ids.include? params[:user_info_id].to_i
          @past_drug = UserInfo.find(params[:user_info_id]).past_drugs
        else
          render json: { errors: "잘못된 접근입니다." }, status: :bad_request
          return
        end
      end
    end

    def update_past_drug
      @past_drug_params = params.permit(:from, :to, :memo, :when, :how)
      if current_user.user_info_ids.include? params[:user_info_id].to_i
        @past_drug = UserInfo.find(params[:user_info_id]).past_drugs.find(params[:id])
      end
    end

    def id_to_modify
      @id_to_modify = params[:id]
    end


    def search_id
      @search_id = params[:search_id]
    end

end
