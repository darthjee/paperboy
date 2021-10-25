# frozen_string_literal: true

class UserScriptController < ApplicationController
   protect_from_forgery except: :show

  def show
    render :show, locals: {
      base_url: base_url
    }
  end

  private

  def base_url
    request.protocol + request.host_with_port
  end
end

