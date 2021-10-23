# frozen_string_literal: true

class User < ApplicationRecord
  class Decorator < ModelDecorator
    expose :id
    expose :name
    expose :email
    expose :login
  end
end
