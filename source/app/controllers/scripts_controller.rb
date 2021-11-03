# frozen_string_literal: true

class ScriptsController < ApplicationController
  include OnePageApplication

  protect_from_forgery except: [:create]

  resource_for :script,
               paginated: true,
               per_page: 10
end
