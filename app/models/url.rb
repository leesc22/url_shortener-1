class Url < ApplicationRecord
	validates :long_url, :short_url, presence: true
	validates :long_url, format: { with: URI.regexp }, allow_blank: true

	def self.retrieve_short_url(long_url)
		url = self.find_by(long_url: long_url)
		url.short_url if url
	end
end
