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
    render json: @current_drug
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

      set_time_memo = CurrentDrug.where(user_info_id: params[:user_info_id], current_drug_id: @search_id).last
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
    @user_info =  UserInfo.find(params[:user_info_id])
    @user_info.past_drug << selected.current_drug
    @user_info.past_drugs.order("created_at").last.update(from: selected.from, to: params[:to] ? params[:to] : Time.zone.now, when: selected.when, how: selected.how)
    render json: @user_info.past_drugs
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_current_drug
      if current_user.has_role? "admin"
        @current_drug = UserInfo.find(params[:user_info_id]).current_drugs
      else
        if current_user.user_info_ids.include? params[:user_info_id].to_i
          @current_drug = UserInfo.find(params[:user_info_id]).current_drugs
        else
          render json: { errors: "잘못된 접근입니다." }, status: :bad_request
          return
        end
      end
    end

    # def set_result
    #   @result = []
    #   UserInfo.find(params[:user_info_id]).current_drugs.each { |d|
    #     @result << { id: d.id, parent_id: d.current_drug.id, name: d.current_drug.name, from: d.from, to: d.to }
    #   }
    # end

    def update_current_drug
      @current_drug_params = params.permit(:from, :to, :memo, :when, :how)
      if current_user.user_info_ids.include? params[:user_info_id].to_i
        @current_drug = UserInfo.find(params[:user_info_id]).current_drugs.find(params[:id])
      end
    end

    def id_to_modify
      @id_to_modify = params[:id]
    end


    def search_id
      @search_id = params[:search_id]
    end

end
