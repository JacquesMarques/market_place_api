require 'rails_helper'

RSpec.describe 'Api::V1::Tokens', type: :request do
  let(:user) { create(:user) }

  describe 'JWT token' do
    it 'should get JWT token' do
      post api_v1_tokens_url, params: { user: { email: user.email, password: '12345' } }, as: :json

      expect(response).to have_http_status(:success)

      json_response = JSON.parse(response.body)
      expect(json_response['token']).not_to be_empty
    end

    it 'should get JWT token' do
      post api_v1_tokens_url, params: { user: { email: user.email, passworsd: 'b@d_pa$$' } }, as: :json

      expect(response).to have_http_status(:unauthorized)
    end
  end

end
