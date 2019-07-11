class User::CurrentDrugsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_current_drug, :search_id, only: [:create, :show, :update, :destroy, :destroy_to_past]
  before_action :update_current_drug, only: [:update]
  before_action :id_to_modify, only: [:update, :destroy, :destroy_to_past]
  
  # GET /current_drugs
  def index
    @current_drugs = CurrentDrug.all

    render json: @current_drugs
  end

  # GET /current_drugs/1
  def show
    require 'review_view'

    @result = @current_drug.as_json
    my_reviews = current_user.drug_reviews
    @result.map { |drug|
      drug_found = Drug.find(drug["current_drug_id"])
      drug_reviews = drug_found.reviews
      review_efficacies = drug_reviews.pluck(:efficacy)
      drug["drug_name"] = drug_found.name
      drug["drug_rating"] = review_efficacies.empty? ? "평가 없음" : (review_efficacies.sum / review_efficacies.count)
      drug["dur_info"] = drug_found.dur_info
      drug["my_review"] = ReviewView.view(my_reviews.find_by(drug_id: drug["current_drug_id"])) unless my_reviews.find_by(drug_id: drug["current_drug_id"]).nil?
    }
    render json: @result 
  end

  # POST /current_drugs
  def create
    require 'dur_analysis'

    drug_found = Drug.find(@search_id)

    if @current_drug.include?(drug_found)
      render json: { errors: "이미 투약 중인 의약품입니다." }, status: :unprocessable_entity
    elsif @current_drug << drug_found
      #dur 정보 추가
      dur_info = DurAnalysis.get_by_drug(DurAnalysis.drug_code([drug_found.id]))
      drug_found.dur_info = dur_info unless dur_info.nil?
      drug_found.save

      set_time_memo = CurrentDrug.where(sub_user_id: params[:sub_user_id], current_drug_id: @search_id).last
      set_time_memo.update(from: params[:from] ? params[:from] : Time.zone.now, to: params[:to], memo: params[:memo], when: params[:when], how: params[:how])
      render json: @current_drug.pluck(:id, :name), status: :created
    else
      render json: @current_drug.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /current_drugs/1
  def update
    if @current_drug.update(@current_drug_params)
      render json: @current_drug
    else
      render json: @current_drug.errors, status: :unprocessable_entity
    end
  end

  # DELETE /current_drugs/1
  def destroy
    CurrentDrug.find(@id_to_modify).delete
  end

  def destroy_to_past
    selected = CurrentDrug.find(@id_to_modify)
    CurrentDrug.find(@id_to_modify).delete
    @sub_user =  SubUser.find(params[:sub_user_id])
    @sub_user.past_drug << selected.current_drug
    @sub_user.past_drugs.order("created_at").last.update(from: selected.from, to: params[:to] ? params[:to] : Time.zone.now, when: selected.when, how: selected.how)
    to = selected.to
    #오늘 날짜 이전에 종료 예정이면 그 날짜, 아니면 복용종료한 날로 입력
    to = Time.zone.now unless (to < Time.zone.now unless to.nil?)
    @sub_user.past_drugs.order("created_at").last.update(from: selected.from, to: to, when: selected.when, how: selected.how)

    render json: @sub_user.past_drugs
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_current_drug
      if current_user.has_role? "admin"
        @current_drug = SubUser.find(params[:sub_user_id]).current_drug
      else
        if current_user.sub_user_ids.include? params[:sub_user_id].to_i
          @current_drug = SubUser.find(params[:sub_user_id]).current_drug
        else
          render json: { errors: "잘못된 접근입니다." }, status: :bad_request
          return
        end
      end
    end

    # def set_result
    #   @result = []
    #   SubUser.find(params[:sub_user_id]).current_drugs.each { |d|
    #     @result << { id: d.id, parent_id: d.current_drug.id, name: d.current_drug.name, from: d.from, to: d.to }
    #   }
    # end

    def update_current_drug
      @current_drug_params = params.permit(:from, :to, :memo, :when, :how)
      if (current_user.has_role? "admin") || (current_user.sub_user_ids.include? params[:sub_user_id].to_i)
        @current_drug = SubUser.find(params[:sub_user_id]).current_drugs.find(params[:id])
      end
    end

    def id_to_modify
      @id_to_modify = params[:id]
    end


    def search_id
      @search_id = params[:search_id]
    end

end
