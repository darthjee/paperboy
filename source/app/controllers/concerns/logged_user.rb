# frozen_string_literal: true

module LoggedUser
  extend ActiveSupport::Concern

  included do
    rescue_from Paperboy::Exception::LoginFailed, with: :not_found
    rescue_from Paperboy::Exception::NotLogged,   with: :not_found
  end

  private

  def save_session
    logged_user_processor.login(user)
  end

  def destroy_session
    logged_user_processor.logoff
  end

  def logged_user
    @logged_user ||= logged_user_processor.logged_user
  end

  def logged_user_processor
    @logged_user_processor ||= Processor.new(self)
  end

  def check_logged!
    raise Paperboy::Exception::NotLogged unless logged_user
  end
end
