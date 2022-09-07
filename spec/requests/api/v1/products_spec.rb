require 'rails_helper'

RSpec.describe 'Api::V1::Products', type: :request do
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

  it 'should create product' do
    post api_v1_products_url,
         params: { product: { title: product.title, price:
           product.price, published: product.published } }, headers: {
             Authorization: JsonWebToken.encode(user_id: product.user_id)
           }, as: :json
    expect(response).to have_http_status(:created)
  end

  it 'should forbid create product' do
    post api_v1_products_url,
         params: { product: { title: product.title, price:
           product.price, published: product.published } }, as: :json
    expect(response).to have_http_status(:forbidden)
  end

  it 'should update product' do
    patch api_v1_product_url(product),
          params: { product: { title: product.title } },
          headers: { Authorization: JsonWebToken.encode(user_id: product.user_id) }, as: :json
    expect(response).to have_http_status(:success)
  end

  it 'should forbid update product' do
    patch api_v1_product_url(product),
          params: { product: { title: product.title } }, as: :json
    expect(response).to have_http_status(:forbidden)
  end

  it 'should destroy product' do
    delete api_v1_product_url(product),
           headers: { Authorization: JsonWebToken.encode(user_id: product.user_id) }, as: :json
    expect(response).to have_http_status(204)
  end
end
