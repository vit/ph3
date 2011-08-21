class IpacsController < ApplicationController
	def index
	end
	def news
		@data = Physcon::App.model.pg.query_inject [], "SELECT newsid, title, content, addtime FROM newsschema.news ORDER BY addtime DESC" do |acc, row|
			acc << row
			acc
		end
	end
#	def about
#	#	render 'about'
#	end
#	def regulations
#	#	render 'index'
#	end
#	def membership
#	#	render 'membership'
#	end
#	def officials
#	#	render 'officials'
#	end
#	def contacts
#	#	render 'contacts'
#	end
end
