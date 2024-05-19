module ExposeWebsite
  extend ActiveSupport::Concern

  def location
    "#{protocol}://#{domain}:#{port}/*"
  end

  private

  def domain
    website.domain || '*'
  end

  def protocol
    website.protocol || '*'
  end

  def port
    website.port || '*'
  end
end
