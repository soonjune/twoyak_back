class User::CurrentSupplementsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_current_supplement, :search_id, only: [:create, :show, :destroy, :destroy_to_past]

  # GET /current_supplements
  def index
    @current_supplements = CurrentSupplement.all

    render json: @current_supplements
  end

  # GET /current_supplements/1
  def show
    render json: @current_supplement
  end

  # POST /current_supplements
  def create
    if @current_supplement << Supplement.find(@search_id) 
      render json: @current_supplement, status: :created
    else
      render json: @current_supplement.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /current_supplements/1
  # def update
  #   if @current_supplement.update(current_supplement_params)
  #     render json: @current_supplement
  #   else
  #     render json: @current_supplement.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /current_supplements/1
  def destroy
    @current_supplement.delete(Supplement.find(@search_id))
  end

  def destroy_to_past
    @current_supplement.delete(Supplement.find(@search_id))
    @past_supplements =  UserInfo.find(params[:user_info_id]).past_sup
    @past_supplements << Supplement.find(@search_id)
    render json: @past_supplements
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_current_supplement
      if current_user.user_info_ids.include? params[:user_info_id].to_i
        @current_supplement = UserInfo.find(params[:user_info_id]).current_sup
      end
    end

    def search_id
      @search_id = params[:search_id]
    end

end
