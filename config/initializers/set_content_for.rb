
module ActionView
	module Helpers
		module CaptureHelper
			def set_content_for(name, content = nil, &block)
				content = capture(&block) if block_given?
				if content
					@view_flow.set(name, content)
					nil
				else
					@view_flow.get(name)
				end
			end
		end
	end
end



