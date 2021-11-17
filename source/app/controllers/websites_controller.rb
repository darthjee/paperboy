# frozen_string_literal: true

class WebsitesController < ApplicationController
  include OnePageApplication

  protect_from_forgery except: [:create, :user_script]

  resource_for :website,
               paginated: true,
               per_page: 10

  def user_script; end

  private

  def website_id
    params[:id] || params.require(:website_id)
  end
end
