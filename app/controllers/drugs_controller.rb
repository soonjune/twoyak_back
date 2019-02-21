class DrugsController < ApplicationController
  before_action :set_drug, only: [:update, :destroy]
  before_action :set_search, only: [:show]

  # GET /drugs
  def index
    @drugs = Drug.all

    render json: @drugs
  end

  # GET /drugs/1
  def show
    render json: @drug
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

  def find_each_drug
    require 'json'

    search = params[:search_term]
    # query = "SELECT * FROM drugs WHERE item_name = " + "'" + search + "'"
    # @rep = Drug.find_by_sql(query) //이전 searchkick 쓰고나서 다음과 같다.
    # Searchkick.search(search, where: {name: /.*#{search}.*/, ingredients: /.*#{search}.*/})
    searched = if search
      Searchkick.search(search, index_name: [Drug, Supplement])
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
      if(item.class == Drug && search == item.item_name)
        @rep = item
        @data["ingr_kor_name"] = JSON.parse(item.ingr_kor_name).uniq.to_s
        @data["ingr_eng_name"] = item.ingr_eng_name
        @data["atc_code"] = item.atc_code
        @data["reviews"] = item.reviews
        if(!item.drug_imprint.nil?)
          @data["drug_imprint"] = item.drug_imprint
        end
        break
      elsif(item.class == Supplement && search == item.product_name)
        @sup = item
        break
      end
    }


    
    if(!@rep.nil?)
      @information = @rep['package_insert']['DRB_ITEM']
      @ITEM_NAME = @rep.item_name

      @data["item_name"] = @ITEM_NAME
      @data["information"] =  @information

    elsif(!@sup.nil?)
      @data["sup"] = @sup
      @data["reviews"] = @sup.reviews
    else
      @data["item_name"] = []
      @data["product_name"] = []
      searched.each { |item|
        if item.class == Drug
          @data["item_name"] << item.item_name
        elsif item.class == Supplement
          @data["product_name"] << item.product_name
        end
      }
    end

    render json: @data
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drug
      @drug = Drug.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def drug_params
      JSON.parse(params.require(:drug))
    end

    def set_search
      @drug = Drug.search(params[:search_term], fields: [name: :exact])
    end
end
