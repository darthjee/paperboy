# frozen_string_literal: true

class DomainScriptsController < ApplicationController
  include OnePageApplication

  protect_from_forgery except: %i[index content]

  def index; end

  def content; end
end
