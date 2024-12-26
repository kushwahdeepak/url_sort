require 'rails_helper'

RSpec.describe DevUrlsController, type: :controller do
  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'GET #new' do
    it 'responds with HTTP status 200' do
        get :new
        expect(response).to have_http_status(:ok)
    end
    end

  describe 'create' do
    context 'with valid attributes' do
      it 'creates a new URL and redirects to show page' do
        post :create, params: { dev_url: { original_url: 'https://example.com' } }
        expect(response).to redirect_to(DevUrl.last)
      end
    end

    context 'with invalid attributes' do
      it 're-renders the new template' do
        post :create, params: { dev_url: { original_url: '' } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'Check redirect' do
    let!(:url) { DevUrl.create(original_url: 'https://example.com', short_url: 'abc123') }

    it 'redirects to the original URL for a valid short URL' do
      get :redirect, params: { short_url: url.short_url }
      expect(response).to redirect_to(url.original_url)
    end

    it 'returns 404 for an invalid short URL' do
      get :redirect, params: { short_url: 'invalid' }
      expect(response).to have_http_status(:not_found)
    end
  end
end