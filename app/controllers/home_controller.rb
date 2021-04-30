class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]
  def welcome
  end
end
