class User::PastSupplementsController < ApplicationController
  before_action :authenticate_request!
  before_action :set_past_supplement, :search_term, only: [:create, :show, :destroy]

  # GET /past_supplements
  def index
    @past_supplements = PastSupplement.all

    render json: @past_supplements
  end

  # GET /past_supplements/1
  def show
    render json: @past_supplement
  end

  # POST /past_supplements
  def create
    if @past_supplement << Supplement.search(@search_term, fields: [name: :exact])
      render json: @past_supplement, status: :created
    else
      render json: @past_supplement.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /past_supplements/1
  # def update
  #   if @past_supplement.update(past_supplement_params)
  #     render json: @past_supplement
  #   else
  #     render json: @past_supplement.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /past_supplements/1
  def destroy
    @past_supplement.delete(Supplement.search(@search_term, fields: [name: :exact]))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_past_supplement
      if current_user.user_info_ids.include? params[:user_info_id].to_i
        @past_supplement = UserInfo.find(params[:user_info_id]).past_sup
      end
    end

    def search_term
      @search_term = params[:search_term]
    end
end
