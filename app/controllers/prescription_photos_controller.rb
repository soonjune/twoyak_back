class PrescriptionPhotosController < ApplicationController
  before_action :authenticate_request!
  before_action :set_prescription_photo, only: [:show, :update, :destroy]

  # GET /prescription_photos
  def index
    is_admin?
    @prescription_photos = PrescriptionPhoto.all

    render json: @prescription_photos
  end

  # GET /prescription_photos/1
  def show
    if current_user.sub_user_ids.include?(@prescription_photo.sub_user_id)
        render json: PrescriptionPhotoSerializer.new(@prescription_photo).serialized_json
    else
      render json: { errors: ['접속 권한이 없습니다.'] }, status: :unauthorized
    end
  end

  # POST /prescription_photos
  def create
    if current_user.sub_user_ids.include?(params[:sub_user_id].to_i)
      s3 = Aws::S3::Resource.new(region:'ap-northeast-2')
      s3_service.set_bucket(s3.bucket('prescriptionphotos'))
      @prescription_photo = PrescriptionPhoto.new(prescription_photo_params)
      @prescription_photo.url = rails_blob_url(@prescription_photo.photo)
      if @prescription_photo.save
        render json: PrescriptionPhotoSerializer.new(@prescription_photo).serialized_json, status: :created, location: @prescription_photo
      else
        @prescription_photo.photo.purge
        render json: @prescription_photo.errors, status: :unprocessable_entity
      end
    else
      render json: { errors: ['접속 권한이 없습니다.'] }, status: :unauthorized
    end
  end

  # PATCH/PUT /prescription_photos/1
  # def update
  #   if @prescription_photo.update(prescription_photo_params)
  #     render json: @prescription_photo
  #   else
  #     render json: @prescription_photo.errors, status: :unprocessable_entity
  #   end
  # end

  # DELETE /prescription_photos/1
  # def destroy
  #   @prescription_photo.destroy
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prescription_photo
      @prescription_photo = PrescriptionPhoto.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def prescription_photo_params
      params.permit(:sub_user_id, :memo, :photo)
    end

    def is_admin?
      if current_user.has_role? "admin"
        return
      else
        render json: { errors: ['접속 권한이 없습니다.'] }, status: :unauthorized
      end
    end
end
