
=begin
class ActionView::TemplateRenderer
#	alias_method :old_render_with_layout, :render_with_layout
	def render_with_layout(path, locals, &block)
	#	content = old_render_with_layout(nil, locals, &block)
		content = yield(false)
	#	path = @view.__next_template
	#	path = 'ipacs/layout'
		#while layout = path && find_layout(@view.next_template, locals.keys) do
	#	layout = path && find_layout(path, locals.keys)
		while (path = @view.__next_template) && (layout = path && find_layout(path, locals.keys))
			@view.__next_template=nil
	#		if layout
			view = @view
			view.view_flow.set(:layout, content)
			content = layout.render(view, locals){ |*name| view._layout_for(*name) }
	#		end
#			path = @view.next_template
		end
		content
	end
end

class ActionView::Base
	attr_accessor :__next_template
end
=end

