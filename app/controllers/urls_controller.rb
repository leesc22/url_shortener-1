class UrlsController < ApplicationController
	def index
		@urls = Url.all
	end

	def new
		@url = Url.new
	end

	def create
		@url = Url.new(url_params)
		@url.shorten_url
		if @url.save
			render 'new'
		else
			@errors = @url.errors.messages
			render 'new'
		end
	end

	def show
		@url = Url.find(params[:id])
	end

	private

	def url_params
		params.require(:url).permit(:long_url)
	end
end
