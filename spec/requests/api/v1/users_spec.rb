require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  let(:user) { create(:user) }

  describe "GET /index" do

    before do
      get api_v1_user_url(user), as: :json
    end

    it 'should return user data' do
      expect(response.status).to eq(200)

      json_response = JSON.parse(self.response.body)
      expect(user.email).to eq(json_response['email'])
    end
  end
end
