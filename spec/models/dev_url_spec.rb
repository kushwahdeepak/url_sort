require 'rails_helper'

RSpec.describe DevUrl, type: :model do
  describe 'validations' do
    it 'valid with a valid original URL' do
      url = DevUrl.new(original_url: 'https://example.com')
      expect(url).to be_valid
    end

    it 'invalid without an original URL' do
      url = DevUrl.new(original_url: nil)
      expect(url).not_to be_valid
    end

    it 'invalid with an improperly formatted URL' do
      url = DevUrl.new(original_url: 'invalid-url')
      expect(url).not_to be_valid
    end
  end

  describe 'callbacks' do
    it 'generates a short URL before create data' do
      url = DevUrl.create(original_url: 'https://example.com')
      expect(url.short_url).not_to be_nil
    end

    it 'check generates short url is unique or not' do
      url1 = DevUrl.create(original_url: 'https://example1.com')
      url2 = DevUrl.create(original_url: 'https://example2.com')
      expect(url1.short_url).not_to eq(url2.short_url)
    end
  end
end