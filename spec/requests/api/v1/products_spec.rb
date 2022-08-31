require 'rails_helper'

RSpec.describe "Api::V1::Products", type: :request do
  let!(:user) { create(:user) }
  let!(:product) { create(:product, user: user) }

  it 'should show products' do
    get api_v1_products_url(), as: :json
    expect(response.status).to eq(200)
  end

  it 'should show product' do
    get api_v1_product_url(product), as: :json

    expect(response.status).to eq(200)
    json_response = JSON.parse(self.response.body)
    expect(product.title).to eq(json_response['title'])
  end
end
