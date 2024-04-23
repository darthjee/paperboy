# frozen_string_literal: true

Magicka::Form.with_element('Magicka::NgSelect', :ng_select)
Magicka::Display.with_element('Magicka::NgSelectText', :ng_select)
Magicka::Display.with_element('Magicka::NgPagination', :pagination)
Magicka::Display.with_element('Magicka::Content', :textarea)
Magicka::Form.with_element('Magicka::Textarea', :textarea)

module Magicka
  class Display < Aggregator
    def button(**args)
      LinkButton.render(renderer: renderer, **args)
    end
  end
end
