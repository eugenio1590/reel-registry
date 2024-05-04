class HomeController < ApplicationController
  def index
    number = NumbService.generate_random_number
    render json: number
  end
end
