class Api::V1::BaseController < ApplicationController
  include Authentication
  include Pagination
end