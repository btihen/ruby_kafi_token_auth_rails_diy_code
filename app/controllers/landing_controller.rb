class LandingController < ApplicationController
  skip_before_action :users_only, only: :index

  def index
  end
end
