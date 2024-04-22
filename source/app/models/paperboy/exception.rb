# frozen_string_literal: true

module Stalchild
  class Exception < StandardError
    class LoginFailed  < Stalchild::Exception; end
    class Unauthorized < Stalchild::Exception; end
    class NotLogged    < Stalchild::Exception; end
  end
end
