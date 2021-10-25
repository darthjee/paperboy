# frozen_string_literal: true

class UserScriptController < ApplicationController
   protect_from_forgery except: %i[show user_script]

  def show
  end

  def user_script
    render :user_script, locals: {
      base_url: base_url
    }
  end

  private

  def base_url
    request.protocol + request.host_with_port
  end
end

