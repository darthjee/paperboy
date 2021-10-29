# frozen_string_literal: true

class PaperboyController < ApplicationController
  protect_from_forgery except: %i[show user_script]

  def show; end

  def user_script; end
end
