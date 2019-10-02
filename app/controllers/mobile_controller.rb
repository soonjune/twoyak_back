class MobileController < ApplicationController
    def version
        @result = Hash.new
        @result['version'] = '1.0.0'
        render json: @result
    end
end
