# frozen_string_literal: true

module Paperboy
  class Exception < StandardError
    class LoginFailed  < Paperboy::Exception; end
    class Unauthorized < Paperboy::Exception; end
    class NotLogged    < Paperboy::Exception; end
  end
end
