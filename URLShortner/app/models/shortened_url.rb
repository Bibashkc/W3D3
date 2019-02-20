class ShortenedUrl < ApplicationRecord
    validates :short_url,:long_url, presence: true, uniqueness: true

    def self.random_code
        urls = SecureRandom.urlsafe_base64
        if self.find_by(short_url:urls)
            ShortenedUrl.random_code
        else
            urls
        end
    end
    def self.create!(user,long_url)
        ShortenedUrl.create(short_url: ShortenedUrl.random_code, long_url: long_url, user_id: user.id )
    end

    belongs_to :submitter,
        class_name: :User,
        primary_key: :id,
        foreign_key: :user_id



end