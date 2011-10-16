class RpcController < ApplicationController
	def call
		user_id = nil
		r = JSON.parse request.body.read
		rpc_method = r['method']
		rpc_params = r['params'] || []
		rpc_result = rpc_error = nil
		rpc_result = Physcon::App.model.lib.get_doc_info(params)

		#if OP_Rights.check @current_user[:user_id], @rpc_method, {rpc_params: @rpc_params, appl: @appl}
		if rpc_method
			eval "rpc_result = Physcon::App.model.#{rpc_method} *rpc_params"
		#else
		end
		render :json => {result: rpc_result, error: rpc_error}
	end

end
