require 'rails_helper'

RSpec.describe Api::V1::ErrorsController, type: :controller do

  before do
    User.destroy_all
    Video.destroy_all
    Error.destroy_all
  end

  after do
    User.destroy_all
    Video.destroy_all
    Error.destroy_all
  end

  it 'Errors list' do
    Error.create(msg: 'error')
    get :index
    expect(response).to be_success
    expect(response).to have_http_status(200)
    resp = JSON.parse(response.body)
    expect(resp.first['msg']).to eq 'error'
  end

end