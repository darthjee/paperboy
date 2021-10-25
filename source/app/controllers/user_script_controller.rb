# frozen_string_literal: true

class UserScriptController < ApplicationController
   protect_from_forgery except: :show

  def show
  end
end

