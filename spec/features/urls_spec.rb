require "rails_helper"

RSpec.feature "Urls", :type => :feature do
	let(:proper_long_url)		{ 'http://www.google.com' }
	let(:improper_long_url)	{ 'wwwabreger' }
	let(:url) { Url.new(long_url: proper_long_url) }

	scenario "User shorten a link" do
		visit urls_path
		click_link "shorten url"
		expect(page.current_path).to eq new_url_path
		fill_in('url[long_url]', :with => proper_long_url)
		click_button "Shorten URL"
		expect(page).to have_content(/.{9}/)
	end

	before(:each) do
		url.shorten_url
		url.save
	end

	scenario "User visit index page" do
		visit urls_path
		expect(page).to have_css('table tr')
		expect(page).to have_content(proper_long_url)
		expect(page).to have_content(/.{9}/)
	end

	scenario "User click on a long URL from index page" do
		visit urls_path
		click_link proper_long_url
		expect(page.current_path).to eq url_path(url)
		expect(page).to have_content(proper_long_url)
		expect(page).to have_content(/.{9}/)
	end
end