# frozen_string_literal: true

module ExposeWebsite
  extend ActiveSupport::Concern

  def location
    "#{protocol}://#{domain}:#{port}/*"
  end

  private

  def domain
    website.domain.present? ? website.domain : '*'
  end

  def protocol
    website.protocol.present? ? website.protocol : '*'
  end

  def port
    website.port.present? ? website.port : '*'
  end
end
