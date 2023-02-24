class HomesController < ApplicationController
  skip_before_action :check_logged_in, only: :index
  def index
  end
  def announcement
  end
end
