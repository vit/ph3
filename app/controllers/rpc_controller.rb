class RpcController < ApplicationController
	def call
		puts request.body.read
		render :json => {qwe: 'rty'}
	end

end
