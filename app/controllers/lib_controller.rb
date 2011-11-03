class LibController < ApplicationController
	def index
	#	@cc = self.class
	end
	def admin

	end
	def doc
		id = params['id'] && params['id'].to_s.length>0 ? params['id'] : nil
		redirect_to '/' unless id
		@doc = Physcon::App.model.lib.get_doc_info id
		@meta = Physcon::App.model.lib.get_doc_meta id
		@children = Physcon::App.model.lib.get_doc_children id
		@authors = Physcon::App.model.lib.get_doc_authors id
		@ancestors = Physcon::App.model.lib.get_doc_ancestors id
		@file_id = Physcon::App.model.lib.find_doc_file id
		@ancestors.unshift({'_id' => nil, 'title' => 'Root'})
	end
	def file
		id = params['id'] && params['id'].to_s.length>0 ? params['id'] : nil
		@file = Physcon::App.model.lib.get_doc_file id

		response.headers['Content-Type'] = @file.content_type
		response.headers["Content-Disposition"] = "attachment; filename=\"#{@file['original_filename']}\""
		response.headers['Cache-Control'] = 'no-cache, must-revalidate, post-check=0, pre-check=0'
		#response.headers['Content-Type'] = 'application/pdf'
		#response.headers['Content-Type'] = 'application/octet-stream'
		self.response_body = @file.read
		#response.headers['Content-Type'] = 'application/pdf'
		#set_content_type(@file.content_type)
	#	render :content_type => @file.content_type
	#	render :content_type => @file.content_type

	end
end
