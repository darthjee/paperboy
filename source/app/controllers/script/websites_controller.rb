# frozen_string_literal: true

class Script < ApplicationRecord
  class WebsitesController < ApplicationController
    include OnePageApplication

    protect_from_forgery except: %i[create show]

    resource_for :website_script, only: %i[index]

    private

    def website_scripts
      script.website_scripts
    end

    def script_id
      params.require(:script_id)
    end

    def script
      Script.find(script_id)
    end
  end
end
