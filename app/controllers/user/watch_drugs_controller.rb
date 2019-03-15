class User::WatchDrugsController < ApplicationController
  before_action :authenticate_request!, only: [:index, :create]
  before_action :authority_check, :watch_drug_params, :set_watch_drug, only: [:create]

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
  def show
    @users_watching = Drug.find(params[:id]).watch_drugs.pluck(:user_id)
    render json: @users_watching
  end

  # POST /watch_drugs
  def create
    if @watch_drug.empty?

      @watch_drug = WatchDrug.new(watch_drug_params)

      if @watch_drug.save
        render json: @watch_drug, status: :created, location: user_watch_drugs_url(id: @watch_drug.id)
      else
        render json: @watch_drug.errors, status: :unprocessable_entity
      end

    else
      @watch_drug.first.destroy
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
    def set_watch_drug
      @watch_drug = WatchDrug.where(user_id: watch_drug_params[:user_id], watch_drug_id: watch_drug_params[:watch_drug_id])
    end

    # def authority_check
    #   if current_user.has_role? "admin"
    #     @watch_drug = WatchDrug.find(params[:id])
    #   elsif current_user.watch_drugs.include? params[:id].to_i
    #       @drug_review = WatchDrug.find(params[:id])
    #   else
    #     render json: { errors: ['권한이 없습니다.'] }, status: :unauthorized
    #   end
    # end

    def authority_check
      if current_user.has_role?("admin") || current_user.user_info_ids.include?(params[:user_info_id].to_i)
        return
      else
        render json: { errors: ['권한이 없습니다.'] }, status: :unauthorized
      end
    end

    # Only allow a trusted parameter "white list" through.
    def watch_drug_params
      params.require(:watch_drug).permit(:user_id, :watch_drug_id)
    end
end
