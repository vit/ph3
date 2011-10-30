class LibController < ApplicationController
	def index
	#	@cc = self.class
	end
	def admin

	end
	def doc
		id = params['id'] && params['id'].to_s.length>0 ? params['id'] : nil
		@doc = Physcon::App.model.lib.get_doc_info id
		@children = Physcon::App.model.lib.get_doc_children id
		@ancestors = Physcon::App.model.lib.get_doc_ancestors id
		@file_id = Physcon::App.model.lib.find_doc_file id
		@ancestors.unshift({'_id' => nil, 'title' => 'Root'})
	end
	def file
		id = params['id'] && params['id'].to_s.length>0 ? params['id'] : nil
		@file = Physcon::App.model.lib.get_doc_file id

		#@response.header['Content-Type'] = @file.content_type
		self.response_body = @file.read
		#set_content_type(@file.content_type)
	#	render :content_type => @file.content_type
	#	render :content_type => @file.content_type

	end
end
