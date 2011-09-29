class DirController < ApplicationController
	def index
		@res_list = Physcon::App.model.pg.query_inject [], "SELECT portalschema.getnewresources('reslist', 10); FETCH ALL IN reslist" do |acc, row|
			acc << row
			acc
		end
		@evt_list = Physcon::App.model.pg.query_inject [], "SELECT portalschema.getnewevents('reslist', 10); FETCH ALL IN reslist" do |acc, row|
			acc << row
			acc
		end
		@cat_list = Physcon::App.model.pg.query_inject [], "select * from portalschema.categories2levels()" do |acc, row|
			acc << row
			acc
		end
		@topic_list = Physcon::App.model.pg.query_inject [], "SELECT portalschema.gettopiclist2('toplist'); FETCH ALL IN toplist" do |acc, row|
			acc << row
			acc
		end
		@topic_map = Physcon::App.model.pg.query_inject( {}, "SELECT portalschema.gettopiclist2('toplist'); FETCH ALL IN toplist" ) do |acc, row|
			acc[row['topid']] = row['title']
			acc
		end
	end
	def any
		@par = params
		@topic = params['topic'].to_i
		@topic_title = (@topic > 0) ? (Physcon::App.model.pg.query_one "SELECT * FROM portalschema.topic WHERE topid='#{@topic}'" do |row|
			row ? row['title'] : ''
		end) : 'All topics'
		@category = params['category'].to_i
		@category_data = {
			title: 'Top categories',
			title0: 'All categories',
			left: 0,
			right: 0
		}.merge (@category > 0) ? (Physcon::App.model.pg.query_one "SELECT * FROM portalschema.category WHERE catid='#{@category}'" do |row|
			row ? {
				title: row['title'],
				title0: row['title'],
				left: row['lft'].to_i,
				right: row['rgt'].to_i
			} : {} 
		end) : {}
		@category_parent_data = {
			title: 'Top categories',
			left: 0,
			right: 0
		}.merge (Physcon::App.model.pg.query_one "
			SELECT c1.lft, c1.rgt, c1.title, (c1.rgt-c1.lft) AS size
			FROM portalschema.category AS c1, portalschema.category AS c2
			WHERE c2.catid='#{@category}' AND c2.lft BETWEEN c1.lft AND c1.rgt AND c1.catid!=c2.catid
			ORDER BY size
		" do |row|
			row ? {
				title: row['title'],
				left: row['lft'].to_i,
				right: row['rgt'].to_i
			} : {} 
		end)
	end
end
