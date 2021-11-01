# frozen_string_literal: true

class WebsitesController < ApplicationController
  include OnePageApplication

  protect_from_forgery except: [:create]

  resource_for :website,
               paginated: true,
               per_page: 10
end
