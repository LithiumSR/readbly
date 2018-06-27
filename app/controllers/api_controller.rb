require 'httparty'
class ApiController < ApplicationController
  include HTTParty
  def get_info
      query = {
          "query"     => params[:query],
          "isbn" => params[:isbn],
          "max_result"      => params[:max_result],
      }
      url = "https://media-information-service.herokuapp.com/book/search"
      response = HTTParty.get(url, :query => query)
      render json: response.body
  end
end

