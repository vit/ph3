class Admin::NewsController < ApplicationController
	def index
		@data = Physcon::App.model.pg.query_inject [], "SELECT newsid, title, content, addtime FROM newsschema.news ORDER BY addtime DESC" do |acc, row|
			acc << row
			acc
		end
#		render :text => @data.inspect
	end
	def new
	end
	def create
		Physcon::App.model.pg.query "insert into newsschema.news (title, content) values ('%s', '%s')", params[:news]['title'], params[:news]['content']
	#	render text: params[:news].inspect
		redirect_to admin_news_items_path
	end
	def show
	end
	def edit
		@id = params['id']
		@data = Physcon::App.model.pg.query_one "select * from newsschema.news where newsid='%s'", @id
		#render text: params.inspect
	end
	def update
		Physcon::App.model.pg.query "update newsschema.news set title='%s', content='%s' where newsid='%s'", params[:news]['title'], params[:news]['content'], params['id']
	#	render text: params.inspect
		redirect_to admin_news_items_path
	end
	def destroy
		#render text: params[:news].inspect
		Physcon::App.model.pg.query "DELETE FROM newsschema.news WHERE newsid='%s'", params['id']
		#render text: params.inspect
		redirect_to admin_news_items_path
	end
#	def lib
#	end
end

