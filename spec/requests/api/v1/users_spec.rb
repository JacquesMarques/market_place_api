require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  let(:user) { create(:user) }

  describe 'GET /index' do

    it 'should return user data' do
      get api_v1_user_url(user), as: :json

      expect(response.status).to eq(200)
      json_response = JSON.parse(self.response.body)
      expect(user.email).to eq(json_response['data']['attributes']['email'])
    end

    it 'should create user' do
      post api_v1_users_url, params: { user: { email: 'test@test.org', password: '123456' } }, as: :json

      expect(response).to have_http_status(:created)
    end

    it 'should not create user with taken email' do
      post api_v1_users_url, params: { user: { email: user .email, password: '123456' } }, as: :json

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'should update user' do
      patch api_v1_user_url(user),
            params: { user: { email: user.email, password: '123456' } },
            headers: { Authorization: JsonWebToken.encode(user_id: user.id) },
            as: :json

      expect(response).to have_http_status(:success)
    end

    it 'should forbid update user' do
      patch api_v1_user_url(user), params: { user: { email: user.email } }, as: :json

      expect(response).to have_http_status(:forbidden)
    end

    it 'should not update user when invalid params are sent' do
      patch api_v1_user_url(user),
            params: { user: { email: 'bad_email', password: '123456' } },
            headers: { Authorization: JsonWebToken.encode(user_id: user.id) },
            as: :json

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'should destroy user' do
      delete api_v1_user_url(user),
             headers: { Authorization: JsonWebToken.encode(user_id: user.id) },
             as: :json

      expect(response).to have_http_status(:no_content)
      expect { user }.to change(User, :count).by(0)
    end

    it 'should forbid destroy user' do
      delete api_v1_user_url(user), as: :json

      expect(response).to have_http_status(:forbidden)
    end
  end
end
