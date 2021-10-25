# frozen_string_literal: true

class ScriptsController < ApplicationController
  include OnePageApplication

  def index
    render :index
  end
end
