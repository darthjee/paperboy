# frozen_string_literal: true

class WebsitesController < ApplicationController
  include OnePageApplication

  protect_from_forgery except: %i[create show]

  resource_for :website_script, only: [:index, :create, :update]
end
