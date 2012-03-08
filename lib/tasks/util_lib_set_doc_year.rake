require 'time'

LIB_DOC_CLASS = 'LIB:DOC'

namespace :util do
	desc "Util test"
	task :set_doc_year => :environment do
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
	end
end

