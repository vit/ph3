class IpacsController < ApplicationController
	def index
		@news_list = Physcon::App.model.pg.query_inject [], "SELECT newsid, title, content, addtime FROM newsschema.news ORDER BY addtime DESC limit 2" do |acc, row|
			acc << row
			acc
		end
		@open_conf_list = Physcon::App.model.pg.query_inject [], "SELECT * FROM context WHERE status>100 and cont_type=1 ORDER BY contid DESC" do |acc, row|
			acc << row
			acc
		end
		#$ctitle1 = htmlspecialchars($row[title]);
		#$chomepage1 = htmlspecialchars($row[homepage]);
		#$cdescr1 = nl2br( htmlspecialchars($row[description]) );
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
