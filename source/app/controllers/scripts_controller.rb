# frozen_string_literal: true

class ScriptsController < ApplicationController
  include OnePageApplication

  protect_from_forgery except: %i[create show]

  resource_for :script,
               except: :index
  resource_for :script,
               only: :index,
               decorator: Script::IndexDecorator,
               paginated: true,
               per_page: 10
end
