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
		@ancestors.unshift({'_id' => nil, 'title' => 'Root'})
	end
end
