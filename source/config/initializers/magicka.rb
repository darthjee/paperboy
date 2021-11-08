# frozen_string_literal: true

Magicka::Display.with_element(Magicka::NgPagination, :pagination)
Magicka::Display.with_element(Magicka::Content, :textarea)
Magicka::Form.with_element(Magicka::Textarea, :textarea)

module Magicka
  class Display < Aggregator
    def button(**args)
      Button.render(renderer: renderer, **args)
    end
  end
end
