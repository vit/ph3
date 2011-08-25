class OldIpacsController < ApplicationController
	def index
		redirect_to '/', :status => 301
	end
	def any
		#redirect_to "/#{params[:action]}", :status => 301
		redirect_to "/#{params[:name]}", :status => 301
	end
end
