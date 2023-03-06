class HomesController < ApplicationController
  skip_before_action :check_logged_in, only: :top
  def top
  end

  def announcement
  end
end
