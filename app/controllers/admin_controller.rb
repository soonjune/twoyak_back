class AdminController < ApplicationController
    before_action :authenticate_request!
    before_action :is_admin?

    # current_drugs_controller로 이동
    # before_action :set_current_drug, only: [:insert]
  
    def index
      @result = Hash.new
      @result["photos"] = []
      PrescriptionPhoto.all.order("id DESC").as_json.map { |photo|
        user_info_temp = UserInfo.find(photo["user_info_id"])
        photo["user_id"] = user_info_temp.user_id
        photo["user_name"] = user_info_temp.user_name
        @result["photos"] << photo
      }
      @result["current_drugs"] = []
      temp = CurrentDrug.all.order("created_at DESC").limit(100)
      temp.as_json.map { |drug|
        drug["name"] = Drug.find(drug["current_drug_id"]).name
        @result["current_drugs"] << drug
      }
      render json: @result
    end
  
    # def insert
    #   if @current_drug.include?(Drug.find(insert_params[:drug_id]))
    #     render json: { errors: "이미 투약 중인 의약품입니다." }, status: :unprocessable_entity
    #   elsif @current_drug << Drug.find(insert_params[:drug_id])
    #     set_time_memo = CurrentDrug.where(user_info_id: insert_params[:user_info_id], current_drug_id: insert_params[:drug_id]).last
    #     set_time_memo.update(from: insert_params[:from], to: insert_params[:to] ? insert_params[:to] : Time.zone.now, memo: insert_params[:memo], when: insert_params[:whern], how: insert_params[:how])
    #     render json: @current_drug.pluck(:id, :name), status: :created
    #   else
    #     render json: @current_drug.errors, status: :unprocessable_entity
    #   end
    # end

    def check
        pr_to_change = PrescriptionPhoto.find(check_params[:id])
        pr_to_change.check = check_params[:check]
        pr_to_change.save
    end


    def push
        require 'json'
        require 'uri'
        require 'net/http'
        
        begin
            uri = URI("http://54.180.189.64:8001/api/push/target")
            target = []
            user = User.find(push_params["user_id"])
            user_token = user.push_token
            target << user_token
            target.to_s
            data = {message: push_params["message"], target: target}

            http = Net::HTTP.new(uri.host, uri.port)
            req = Net::HTTP::Post.new(uri.request_uri, {'Content-Type': 'application/x-www-form-urlencoded'})
            req.set_form_data(data)
            
            response = http.request(req)

            render json: user, status: 200
        rescue
            render json: "푸시 알람 실패", status: 500
        end
    end

    def push_all
        require 'json'
        require 'uri'
        require 'net/http'

        begin
            uri = URI("http://54.180.189.64:8001/api/push/all")
 
            message = push_params["message"]
            data = {message: message}

            http = Net::HTTP.new(uri.host, uri.port)
            req = Net::HTTP::Post.new(uri.request_uri, {'Content-Type': 'application/x-www-form-urlencoded'})
            req.set_form_data(data)

            response = http.request(req)
            
            render json: "유저 전체에  #{message}  푸시 알람 전송 완료", status: 200
        rescue
            render json: "푸시 알람 실패", status: 500
        end
    end

    private
  
    # def insert_params
    #   params.permit(:user_info_id, :drug_id, :from, :to, :memo, :when, :how)
    # end

    def check_params
      params.permit(:id, :check, :memo)
    end

    def push_params
      params.permit(:user_id, :message)
    end
  
    def is_admin?
      if current_user.has_role? "admin"
        return
      else
        render json: { errors: ['접속 권한이 없습니다.'] }, status: :unauthorized
      end
    end

    def set_current_drug
        if current_user.has_role? "admin"
          @current_drug = UserInfo.find(params[:user_info_id]).current_drug
        else
          if current_user.user_info_ids.include? params[:user_info_id].to_i
            @current_drug = UserInfo.find(params[:user_info_id]).current_drug
          else
            render json: { errors: "잘못된 접근입니다." }, status: :bad_request
            return
          end
        end
      end

  end