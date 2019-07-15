class DrugsController < ApplicationController
  before_action :set_drug, only: [:show, :update, :destroy, :show_pics]
  before_action :authenticate_request!,  only: [:create, :update, :destroy]
  before_action :check_authority, only: [:create, :update, :destroy]  
  # before_action :set_search, only: [:show]

  # GET /drugs
  def index
    @drugs = Drug.all

    render json: @drugs
  end

  # GET /drugs/1
  def show
    Searchkick.disable_callbacks
    #안전정보 우선 확인
    if @drug.dur_info.nil?
      require 'dur_analysis'
      dur_info = DurAnalysis.get_by_drug(DurAnalysis.drug_code([@drug.id]))
      @drug.dur_info = dur_info unless dur_info.nil?
      @drug.save    
    end
    
    @data = Hash.new
    @data = @drug.as_json
    @data["ingr_kor_name"] = JSON.parse(@drug["ingr_kor_name"]) unless (@drug["ingr_kor_name"].nil? || @drug["ingr_kor_name"].kind_of?(Array))
    if params[:sub_user_id].present?
      if SubUser.find(params[:sub_user_id]).current_drug_ids.include?(@drug.id)
        @data["currently_taking?"] = true
      end
    end
    @data["taking"] = @drug.currents.count
    @data["watching"] = @drug.watch_drugs.pluck(:user_id)

    render json: @data
  end

  def show_pics
    require 'nokogiri'
    require 'open-uri'

    doc = Nokogiri::HTML(open("https://nedrug.mfds.go.kr/pbp/CCBBB01/getItemDetail?itemSeq=#{@drug.item_seq}"))
    pics = doc.css('.pc-img img')
    if pics.empty?
      doc = Nokogiri::HTML(open("https://nedrug.mfds.go.kr/pbp/CCBBB01/getItemDetail?itemSeq=#{@drug.item_seq}"))
      pics = doc.css('.pc-img img')
    end
    @url = []
    pics.each { |pic|
      @url << pic.attr('src')
    }
    render json: { pics: @url }
  end

  # POST /drugs
  def create
    @drug = Drug.new(drug_params)

    if @drug.save
      render json: @drug, status: :created, location: @drug
    else
      render json: @drug.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /drugs/1
  def update
    if @drug.update(drug_params)
      render json: @drug
    else
      render json: @drug.errors, status: :unprocessable_entity
    end
  end

  # DELETE /drugs/1
  def destroy
    @drug.destroy
  end

  def find_drug_web
    require 'json'

    search = params[:search_term]
    # query = "SELECT * FROM drugs WHERE item_name = " + "'" + search + "'"
    # @rep = Drug.find_by_sql(query) //이전 searchkick 쓰고나서 다음과 같다.
    # Searchkick.search(search, where: {name: /.*#{search}.*/, ingredients: /.*#{search}.*/})
    searched = if search
      Searchkick.search(search, {
        index_name: [Drug, Supplement],
        fields: [{name: :word_middle}],
        limit: 50
        # misspellings: {below: 5}
      })
    end

    # 뭐 검색됐는지 확인용
    # searched.each { |item|
    #   if item.class == Drug
    #     puts item.item_name
    #   elsif item.class == Supplement
    #     puts item.product_name
    #   end
    # }
  
    @data = Hash.new
  
    searched.each { |item|
      if(item.class == Drug && search == item.name)
        #drugs/:id로 직접 접근하는 것과 동일한 화면 표시를 위해 redirection
        @id = item.id
        redirect_to drug_path(@id)
        #검색 이전 코드
        # @rep = item
        # @data["drug_id"] = @rep.id
        # @data["ingr_kor_name"] = JSON.parse(item.ingr_kor_name).uniq.to_s
        # @data["ingr_eng_name"] = item.ingr_eng_name
        # @data["atc_code"] = item.atc_code
        # @data["taking"] = item.currents.count
        # @data["watching"] = item.watch_drugs.pluck(:user_id)
        # if(!item.drug_imprint.nil?)
        #   @data["drug_imprint"] = item.drug_imprint
        # end
        return
      elsif(item.class == Supplement && search == item.name)
        @sup = item
        break
      end
    }


    
    if(!@rep.nil?)
      if !@rep['package_insert'].nil?
        @information = @rep['package_insert']['DRB_ITEM']
        @ITEM_NAME = @rep.name

        @data["item_name"] = @ITEM_NAME
        @data["information"] =  @information
      else
        @data["item_name"] = @rep.name
      end

    elsif(!@sup.nil?)
      @data["sup"] = @sup
      @data["reviews"] = @sup.reviews
    else
      @data["item_name"] = []
      @data["product_name"] = []
      searched.each { |item|
        if item.class == Drug
          @data["item_name"] << {current_drug_id: item.id, name: item.name}
        # 건강기능식품
        # elsif item.class == Supplement
        #   @data["product_name"] << {id: item.id, name: item.name}
        end
      }
    end

    render json: @data
  end

  def find_drug_mobile
    require 'json'

    search = params[:search_term]
    # query = "SELECT * FROM drugs WHERE item_name = " + "'" + search + "'"
    # @rep = Drug.find_by_sql(query) //이전 searchkick 쓰고나서 다음과 같다.
    # Searchkick.search(search, where: {name: /.*#{search}.*/, ingredients: /.*#{search}.*/})
    searched = if search
      Searchkick.search(search, {
        index_name: [Drug, Supplement],
        fields: [{name: :word_middle}],
        limit: 50
        # misspellings: {below: 5}
      })
    end

    @data = Hash.new

    @data["item_name"] = []
    @data["product_name"] = []
    searched.each { |item|
      if item.class == Drug
        @data["item_name"] << {current_drug_id: item.id, name: item.name}
      # 건강기능식품
      # elsif item.class == Supplement
      #   @data["product_name"] << {id: item.id, name: item.name}
      end
    }

    render json: @data
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drug
      @drug = Drug.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def drug_params
      params.require(:drug).permit(:short_description, :short_notice)
    end

    def check_authority
      unless current_user.has_role? "admin"
        render json: { errors: ['권한이 없습니다.'] }, status: :unauthorized
        return
      end
    end

    # using elastic
    # def set_search
    #   @drug = Drug.search(params[:search_term], fields: [name: :exact])
    # end
end
