# frozen_string_literal: true

class WebsitesController < ApplicationController
  include OnePageApplication

  helper_method :user_script_wrapper

  protect_from_forgery except: %i[create user_script]

  resource_for :website,
               paginated: true,
               per_page: 10

  def user_script; end

  private

  def website_id
    params[:id] || params.require(:website_id)
  end

  def user_script_wrapper
    @user_script_wrapper ||= Website::UserScript.new(website)
  end
end
