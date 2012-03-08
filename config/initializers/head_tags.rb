
module ActionView
	module Helpers
		module CaptureHelper
		#module HeadTagsHelper
			def add_head_tag name, data
				@__head_tags ||= []
				@__head_tags << {name: name, data: data}
			end
			def get_head_tags
				@__head_tags ? @__head_tags : []
			end
		end
	end
end



