# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionHelper
  before_action :check_logged_in

  def check_logged_in
    return if current_user

    redirect_to root_path
  end

  after_action :flash_turbo_frame
  def flash_turbo_frame
    return if response.redirect?

    message = {}
    if turbo_frame_request?
      message = flash.transform_values do |_message|
        # XSS対策&日本語のエスケープ
        CGI.escape(ERB::Util.html_escape(_message).to_s)
      end.to_json
      flash.discard
    end
    response.set_header(
      'X-Flash-Messages',
      message
    )
  end
end
