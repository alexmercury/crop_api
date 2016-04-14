require 'rails_helper'

RSpec.describe Api::V1::VideoController, type: :controller do

  describe 'POST #crop' do

    it 'responds successfully with an HTTP 200 status code' do
      post :crop

      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

  end
end
