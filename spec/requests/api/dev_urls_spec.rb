require 'rails_helper'

RSpec.describe Api::DevUrlsController, type: :controller do
  let(:valid_token) { Api::DevUrlsController::API_TOKEN }
  let(:invalid_token) { "invalid_token" }
  let(:valid_url) { "https://example.com" }
  let(:invalid_url) { "" }

  describe "POST #create" do
    context "when authentication token is valid" do
      before do
        request.headers['Authorization'] = valid_token
      end

      context "with valid URL parameters" do
        it "creates a new DevUrl and returns a short URL" do
          post :create, params: { original_url: valid_url }
          expect(response).to have_http_status(:created)
          expect(JSON.parse(response.body)).to have_key("short_url")
        end
      end

      context "with invalid URL parameters" do
        it "does not create a DevUrl and returns an error" do
          post :create, params: { original_url: invalid_url }
          expect(JSON.parse(response.body)).to have_key("error")
        end
      end
    end

    context "when authentication token is invalid" do
      before do
        request.headers['Authorization'] = invalid_token
      end

      it "returns unauthorized" do
        post :create, params: { original_url: valid_url }
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context "when authentication token is missing" do
      it "returns unauthorized" do
        post :create, params: { original_url: valid_url }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
