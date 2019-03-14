class WatchDrugsController < ApplicationController
  before_action :authenticate_request!, only: [:index, :create, :destroy]
  before_action :authority_check, only: [:create]

  # GET /watch_drugs
  def index
    if current_user.has_role? "admin"
      @watch_drugs = WatchDrug.all
      render json: @watch_drugs
    else
      render json: { errors: ['권한이 없습니다.'] }, status: :unauthorized
    end
  end

  # GET /watch_drugs/1
  # def show
  #   render json: @watch_drug
  # end

  # POST /watch_drugs
  def create
    @watch_drug = WatchDrug.new(watch_drug_params)

    if @watch_drug.save
      render json: @watch_drug, status: :created, location: @watch_drug
    else
      @watch_drug.destroy
      render json: @watch_drug.errors, status: :unprocessable_entity
    end
  end

  # # PATCH/PUT /watch_drugs/1
  # def update
  #   if @watch_drug.update(watch_drug_params)
  #     render json: @watch_drug
  #   else
  #     render json: @watch_drug.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /watch_drugs/1
  # def destroy
  #   @watch_drug.destroy
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_watch_drug
    #   @watch_drug = WatchDrug.find(params[:id])
    # end

    def authority_check
      if current_user.has_role? "admin"
        @watch_drug = WatchDrug.find(params[:id])
      else
        if current_user.watch_drugs.include? params[:id].to_i
          @drug_review = WatchDrug.find(params[:id])
        end
      end
    end

    # Only allow a trusted parameter "white list" through.
    def watch_drug_params
      params.require(:watch_drug).permit(:user_id, :watch_drug_id)
    end
end
