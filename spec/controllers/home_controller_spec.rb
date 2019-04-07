require 'spec_helper'
require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'Home page' do
    before { get :distance, params: { address: '1088 Budapest, Múzeum krt. 14-16' } }

    it 'responds successfully for valid address' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end
end
