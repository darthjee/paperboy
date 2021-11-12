# frozen_string_literal: true

class WebsiteScriptsController < ApplicationController
  protect_from_forgery except: %i[index content]

  resource_for :website_script, only: :index

  def content; end
end
