# frozen_string_literal: true

require 'spec_helper'

describe HomeController do
  describe 'GET show' do
    render_views

    before do
      get :show, params: { ajax: true }
    end

    it { expect(response).to be_successful }

    it { expect(response).to render_template('home/show') }
  end
end
