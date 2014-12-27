class HomeController < ApplicationController
  before_filter :authenticate_user!
  layout "another"
  def index
  end
end
