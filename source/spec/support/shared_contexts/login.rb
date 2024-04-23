# frozen_string_literal: true

shared_context 'when user logged', logged: true do
  let(:logged_user) { create(:user) }
  let(:session)     { create(:session, user: logged_user) }

  before do
    controller.send(:cookies).signed[:session] = session&.id
  end
end

shared_context 'when user is not logged', not_logged: true do
  let(:session) { nil }
end
