# frozen_string_literal: true

require 'spec_helper'

describe PaperboyController do
  describe 'GET show' do
    render_views

    before do
      get :show, params: { format: :js }
    end

    it { expect(response).to be_successful }

    it { expect(response).to render_template('paperboy/show') }
  end

  describe 'GET user_script' do
    render_views

    before do
      get :user_script, params: { format: :js }
    end

    it { expect(response).to be_successful }

    it { expect(response).to render_template('paperboy/user_script') }
  end
end
