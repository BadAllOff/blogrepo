require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  %w(about_me).each do |page|
    context "on GET to /pages/#{page}" do
      before do
        get :show, id: page
      end

      it { expect(response).to have_http_status(:success) }
      it { expect(response).to render_template(page) }
    end
  end
end
