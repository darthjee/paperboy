# frozen_string_literal: true

class WebsiteScriptsController < ApplicationController
  protect_from_forgery except: %i[index content]

  resource_for :website_script, only: :index

  def content; end
  
  private

  def website_scripts
    WebsiteScript.where(website: websites)
  end

  def websites
    Website.for(request_url)
  end

  def request_url
    params.require(:url)
  end
end
