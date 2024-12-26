class DevUrl < ApplicationRecord
    before_create :create_short_url
    validates :original_url, presence: true, format: URI::regexp(%w[http https])
    def create_short_url
        self.short_url = SecureRandom.hex(3)
    end

end
