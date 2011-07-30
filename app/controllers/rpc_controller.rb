class RpcController < ApplicationController
	def call
		user_id = nil
	#	puts Physcon::App.model.inspect
	#	puts "!!!"
		puts request.body.read
		render :json => {qwe: 'rty'}
	end

end
