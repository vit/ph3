#

#$(document).ready ->
#$ -> ((box)->
((box)->

	loadAncestors = (id, callback) -> rpc 'lib.get_doc_ancestors', [id], (res, err)-> callback res.result
	loadInfo = (id, callback) -> rpc 'lib.get_doc_info', [id], (res, err)-> callback res.result
	loadChildren = (id, callback) -> rpc 'lib.get_doc_children', [id], (res, err)-> callback res.result
	loadConfsList = (callback) -> rpc 'coms.get_confs_list', [], (res, err)-> callback res.result
	loadConfPapersList = (id, callback) -> rpc 'coms.get_conf_accepted_papers_list', [id], (res, err)-> callback res.result
	#new_doc = (parent, dir, data, callback) -> rpc 'lib.new_doc', [parent, dir, data], (res, err)-> callback res.result
	new_doc = (parent, dir, data, callback) ->
		#alert escape(JSON.stringify(data))
		rpc 'lib.new_doc', [parent, dir, data], (res, err)-> callback res.result

	DocPath = (-> (div) ->
		currInfo = null
		id = null
		panel = (->
			renderOne = (v) ->
				$('<span>').append($('<a href="#">').click( (e)->
					e.preventDefault()
					notifier.notify('changed', v._id)
				).text(v.title)).appendTo(div)
			render = (list) ->
				div.empty()
				#renderOne {_id: null, title: 'Library'}
				list.unshift {_id: null, title: 'Library'}
				for v in list
					renderOne v
					$('<span> / </span>').appendTo(div)
				null
			{
				render: render
			}
		)()
		me = {
			render: (list) -> 
				panel.render list
			load: (_id) ->
				id = _id
				loadAncestors id, (list) ->
					me.render list
				null
		}
		me
	)()
	DocInfo = (-> (div) ->
		currInfo = null
		id = null
		panel = (->
			viewDiv = $('<div>').appendTo div
			viewTitle = $('<span>')
			editTitle = $('<input type="text" wwidth="100%">').width('100%')
			viewAbstract = $('<span>')
			editAbstract = $('<textarea wwidth="100%">').width('100%')
			editBtn = $('<button>Edit</button>').click () ->
				showEdit()
			saveBtn = $('<button>Save</button>').click () ->
				currInfo.title = editTitle.val()
				currInfo.abstract = editAbstract.val()
				showView()
			cancelBtn = $('<button>Cancel</button>').click () ->
				showView()
			viewElms = [viewTitle, viewAbstract, editBtn]
			editElms = [editTitle, editAbstract, saveBtn, cancelBtn]
			showView = ->
				if id
					viewTitle.text(currInfo.title)
					viewAbstract.text(currInfo.abstract)
					elm.show() for elm in viewElms
				else
					elm.hide() for elm in viewElms
				elm.hide() for elm in editElms
			showEdit = ->
				if id
					editTitle.val(currInfo.title)
					editAbstract.val(currInfo.abstract)
					elm.show() for elm in editElms
				else
					elm.hide() for elm in editElms
				elm.hide() for elm in viewElms
			viewDiv.append('<b>Title:</b> ').append(viewTitle).append(editTitle)
				.append('<br>')
				.append('<b>Abstract:</b> ').append(viewAbstract).append(editAbstract)
				.append('<br>')
				.append(editBtn)
				.append(saveBtn)
				.append(cancelBtn)
			#showView()
			{
				showView: showView
			}
		)()
		me = {
			render: (info) -> 
			#	if info
				#currInfo = info || {title: '', abstract: ''}
				currInfo = info
				panel.showView()
				null
			load: (_id) ->
				id = _id
				loadInfo id, (info) ->
					me.render info
				null
		}
		me
	)()
	DocChildren = (-> (div) ->
		id = null
		panel = (->
			stdDiv = $('<div>').appendTo div
			addDiv = $('<div>').appendTo div
			importDiv = $('<div>').appendTo div
			listDiv = $('<div>').appendTo div
			showStd = ->
				stdDiv.show()
				addDiv.hide()
				importDiv.hide()
			showAdd = ->
				addDiv.show()
				stdDiv.hide()
			showImport = ->
				importBlock.load()
				#loadConfsList (result)-> alert JSON.stringify result
				importDiv.show()
				stdDiv.hide()
			(->
				addBtn = $('<button>Add</button>').click () -> showAdd()
				importBtn = $('<button>Import</button>').click () -> showImport()
				stdDiv.append(addBtn)
				stdDiv.append(importBtn)
			)()
			(->
				addTitle = $('<input type="text">').width('100%')
				addAbstract = $('<textarea>').width('100%')
				saveBtn = $('<button>Save</button>').click () ->
					new_doc id, false, {
						title: addTitle.val(),
						abstract: addAbstract.val()
					}, (result) ->
						showStd()
						me.load id
				cancelBtn = $('<button>Cancel</button>').click () -> showStd()
				addDiv.append('<i>Add new item</i><br>')
					.append('<b>Title:</b> ').append(addTitle)
					.append('<br>')
					.append('<b>Abstract:</b> ').append(addAbstract)
					.append('<br>')
					.append(saveBtn)
					.append(cancelBtn)
			)()
			importBlock = ((cancelBtn, importBtn, t, tb, td1, td2, listDiv, CB, renderConfs)->
				cancelBtn = $('<button>Cancel</button>').click () -> showStd()
				importBtn = $('<button>Import checked</button>').click () ->
					alert(JSON.stringify CB.getSelected())
				importDiv.append('<i>Import papers from conferences</i><br>')
				importDiv.append( t=$('<table>').append( tb=$('<tbody>') ) ).append(cancelBtn).append(importBtn)
				tb.append( td1=$('<td valign="top">') )
				tb.append( td2=$('<td valign="top">') )
				listDiv = $('<div>')
				td2.append( $('<input type="checkbox">').change( (e)->
					if $(e.target).attr('checked') then CB.selectAll()
					else CB.deselectAll()
				)).append('<b>Select/Deselect all</b>').append(listDiv)
				CB = ((Constr, list)->
					list = []
					Constr = (v)->
						((cb)->
							cb = $('<input type="checkbox">')
							list.push({elm: cb, data: v})
							#$('<li>').append(cb = $('<input type="checkbox">')).append($('<span>').text(v.authors+' | '+v.title))
							$('<li>').append(cb).append($('<span>').text(v.authors+' | '+v.title))
						)()
					Constr.selectAll = -> $.each list, (k,v)-> v.elm.attr("checked","checked")
					Constr.deselectAll = -> $.each list, (k,v)-> v.elm.removeAttr("checked")
					Constr.clearList = ->
						list = []
						null
					Constr.getSelected = ->
						((rez=[])->
							$.each list, (k,v) ->
								rez.push({context: v.data.context, papnum: v.data.papnum}) if v.elm.attr('checked')
							rez
						)()
					Constr
				)()
				renderConfs = (list) ->
					td1.empty()
					#for v in list
					$.each list, (k, v)->
						$('<li>').append($('<a href="#">').click( (e)->
							e.preventDefault()
							#alert(v.contid)
							#loadConfPapersList v.contid, (list)-> alert JSON.stringify list
							loadConfPapersList v.contid, (list)-> renderPapers list
							#-> notifier.notify('changed', v._id)
						).text(v.title)).appendTo(td1)
				renderPapers = (list) ->
					listDiv.empty()
					CB.clearList()
					$.each list, (k, v)->
						elm = CB(v)
						listDiv.append(elm)
					#CB.selectAll()
				{
					load: ->
						loadConfsList (result)->
							#alert JSON.stringify result
							renderConfs result
				}
			)()
			childrenList = ((ul)->
				ul = $('<ul>').appendTo(listDiv)
				{
					render: (list) ->
						ul.empty()
						$.each list, (k, v)->
							$('<li>').append($('<a href="#">').click( (e)->
								e.preventDefault()
								notifier.notify('changed', v._id)
							).text(v.info.title)).appendTo(ul)
				}
			)()
			showStd()
			{
				renderChildren: (list) ->
					showStd()
					childrenList.render list
			}
		)()
		#ul = $('<ul>').appendTo(div)
		me = {
		#	render: (children) -> 
		#		panel.renderChildren children
		#		ul.empty()
		#		for v in children
		#			((v) ->
		#				$('<li>').append($('<a href="#">').click(
		#					-> notifier.notify('changed', v._id)
		#				).text(v.info.title)).appendTo(ul)
		#			)(v)
		#		null
			load: (_id) ->
				id = _id
				loadChildren id, (children) ->
					#me.render children
					panel.renderChildren children
				null
		}
		me
	)()
	DocPage = (-> (container) ->
		pageDiv = $('<div></div>').appendTo container
		pathDiv = $('<div></div>').appendTo( pageDiv.append($('<div>')) )
		infoDiv = $('<div></div>').appendTo( pageDiv.append($('<div>').append($('<h3>').text('Info'))) )
		childrenDiv = $('<div></div>').appendTo( pageDiv.append($('<div>').append($('<h3>').text('Children'))) )
		docPath = new DocPath(pathDiv)
		docInfo = new DocInfo(infoDiv)
		docChildren = new DocChildren(childrenDiv)
		notifier.attach 'changed', (id) ->
			me.showDoc(id)
		me = {
			showDoc: (id) -> 
				#docInfo.render data.info
				docPath.load id
				docInfo.load id
				#docChildren.render data.children
				docChildren.load id
		}
		me
	)()
	notifier = Mixin {}, Mixin.Observable

	ipacs = {admin: {}}
	box.ipacs = ipacs
	ipacs.admin.Lib = (()->
		(container) ->
			docPage = new DocPage(container)
			docPage.showDoc(null)
	)()

)(window)


