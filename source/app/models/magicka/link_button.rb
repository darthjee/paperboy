# frozen_string_literal: true

module Magicka
  # Button element representing an HTML +<button/>+
  class Button < Magicka::Button
    with_attribute_locals :href
    template_folder 'templates/display'
  end
end
