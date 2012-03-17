#encoding: utf-8
require 'mysql'

LIB_DOC_CLASS = 'LIB:DOC'

namespace :util_lib do
	desc "Reindex library search index"
	task :search_reindex_all => :environment do
	#conn = Mysql.real_connect('localhost', '', '', '', 9306, nil, 0)
#	conn = Mysql.real_connect('127.0.0.1', '', '', '', 9306, nil, 0)
	#conn.query("replace into rt (id, title, content) values (123, 'test title text', 'test content text когда не от худа и не от добра')")

#	stmt = conn.prepare("replace into rt (id, title, content) values (?, ?, ?)")
#	stmt.execute 321, 'test title text', 'test content text когда не от худа и не от добра'
#	stmt.close

#	conn.close


	#conn.query("select 1 from rt")


	#	Physcon::App.model.sphinx.query_each 'select * from %s', 'rt' do |row|
	#		p row
	#	end


	#	puts Physcon::id_to_int64 'ffff'
	#	puts Physcon::id_to_int64 'ffffffff'
	#	puts Physcon::id_to_int64 'ffffffffffffffff'
	#	puts Physcon::id_to_int64 'fffffffffffffffff'
	#	puts (Physcon::id_to_int64 'fffffffffffffffff') & 0xffffffffffffffff

#=begin
		Physcon::App.model.lib.each_doc { |d|
			#if d['info'] && !d['info']['dir']
			if d['info']
				title = d['info']['title']
				abstract = d['info']['abstract']
				_id = d['_id']
				id = Physcon::id_to_int64(_id).to_s
				#authors = d['info']['authors'].inspect
				_authors = d['authors']
				authors = _authors ? _authors.map{|a| a['fname']+' '+a['lname'] }.join(', ') : ''
#				puts authors
#				puts title
#				puts abstract
#				puts id
#				Physcon::App.model.sphinx.query "replace into rt (id, title, content) values (%s, '%s', '%s')", id, title, abstract
				Physcon::App.model.sphinx.query "replace into rt (id, title, content) values (%s, '%s', '%s')", id, title, abstract+"\n"+authors
				Physcon::App.model.sphinx.query "FLUSH RTINDEX rt"
			end
		}
#=end

=begin
		contexts = {}
		Physcon::App.model.coms.get_confs_list.each { |d|
			str = d['title']+' '+d['description']
			rez = str.match('\d{4,4}')
			if rez
				year = rez.to_s.to_i
				if year > 2000 and year < 2013
					contexts[d['contid'].to_i] = year
				#	puts year
				end
			end
		}
		puts contexts

		Physcon::App.model.lib.each_doc { |d|
			if d['info'] && !d['info']['dir']
				if d['_meta'] && d['_meta']['origin'] && d['_meta']['origin']['context'] && d['_meta']['origin']['papnum']
					ctime = d['_meta']['ctime']
					year = Time.parse(ctime).year.to_i
					contid = d['_meta']['origin']['context'].to_i
					papnum = d['_meta']['origin']['papnum'].to_i
					year = contexts[contid] if contexts[contid]
#					Physcon::App.model.lib.docs.update({'_meta.class' => LIB_DOC_CLASS, '_id' => d['_id']}, {'$set' => {'info.publication_year' => year}})
				end
				puts d.inspect
			end
		}
		puts
=end
	end
end

