require 'rails_helper'

RSpec.describe Url, type: :model do
	let(:proper_long_url)		{ 'http://www.google.com' }
	let(:proper_short_url)	{ SecureRandom.base64[0..8] }
	let(:improper_long_url)	{ 'wwwabreger' }


	context "validation: " do
		it { is_expected.to validate_presence_of(:long_url) }
		it { is_expected.to allow_value(proper_long_url).for(:long_url) }
		it { is_expected.not_to allow_value(improper_long_url).for(:long_url)  }
		it { is_expected.to validate_presence_of(:short_url) }
	end

	context "creates: " do
		it "takes in one valid long_url" do
			expect{ Url.create(long_url: proper_long_url) }.not_to raise_error
		end

		it "won't create an entry if only one valid long_url is being supplied" do
			Url.create(long_url: proper_long_url)
			expect( Url.find_by(long_url: proper_long_url) ).to be nil
		end

		it "takes 2 inputs with proper long url" do
			expect{ Url.create(long_url: proper_long_url, short_url: proper_short_url) }.not_to raise_error
		end

		it "creates an entry when 2 inputs with proper_long_url is being supplied" do
			Url.create(long_url: proper_long_url, short_url: proper_short_url)
			expect( Url.find_by(long_url: proper_long_url) ).not_to be nil
		end
	end

	context "self.retrieve_short_url: " do
		it "takes in one valid long_url" do
			expect{ Url.retrieve_short_url(proper_long_url) }.not_to raise_error
		end

		it "returns nil when proper long_url is not found" do
			expect( Url.retrieve_short_url(proper_long_url) ).to be nil
		end

		it "returns short_url when proper long_url is found" do
			Url.create(long_url: proper_long_url, short_url: proper_short_url)
			expect( Url.retrieve_short_url(proper_long_url) ).to eq proper_short_url
		end
	end

end