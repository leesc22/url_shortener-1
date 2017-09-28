class UrlsController < ApplicationController
	def index
	end

	def new
		@url = Url.new
	end

	def create
		@url = Url.new(url_params)
		@url.shorten_url
		if @url.save
			redirect_to urls_path
		else
			@errors = @url.errors.messages
			render 'new'
		end
	end

	private

	def url_params
		params.require(:url).permit(:long_url)
	end
end
