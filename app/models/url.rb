class Url < ApplicationRecord
	validates :long_url, :short_url, presence: true
	validates :long_url, format: { with: URI.regexp }, allow_blank: true
	# before_save :shorten_url
	# before_save happens after validation, validation fail and before_save never invoked

	def self.retrieve_short_url(long_url)
		url = self.find_by(long_url: long_url)
		url.short_url if url
	end

	def shorten_url
		self.short_url = SecureRandom.base64[0..8]
	end
end
