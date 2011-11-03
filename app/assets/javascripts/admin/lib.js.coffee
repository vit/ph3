#

#$(document).ready ->
#$ -> ((box)->
((box)->

	loadAncestors = (id, callback) -> rpc 'lib.get_doc_ancestors', [id], (res, err)-> callback res.result
	loadInfo = (id, callback) -> rpc 'lib.get_doc_info', [id], (res, err)-> callback res.result
	loadChildren = (id, callback) -> rpc 'lib.get_doc_children', [id], (res, err)-> callback res.result
	loadConfsList = (callback) -> rpc 'coms.get_confs_list', [], (res, err)-> callback res.result
	loadConfPapersList = (id, callback) -> rpc 'coms.get_conf_accepted_papers_list', [id], (res, err)-> callback res.result
	importConfPapers = (id, list, callback) -> rpc 'lib.import_docs_from_coms', [id, list], (res, err)-> callback res.result
	removeDocs = (list, callback) -> rpc 'lib.remove_docs', [list], (res, err)-> callback res.result
	#new_doc = (parent, dir, data, callback) -> rpc 'lib.new_doc', [parent, dir, data], (res, err)-> callback res.result
	#new_doc = (parent, dir, data, callback) -> rpc 'lib.new_doc', [parent, dir, data], (res, err)-> callback res.result
	new_doc = (parent, data, callback) -> rpc 'lib.new_doc', [parent, data], (res, err)-> callback res.result
	saveInfo = (id, info, callback) -> rpc 'lib.set_doc_info', [id, info], (res, err)-> callback res.result

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
				list.unshift {_id: null, title: 'Root'}
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
		panel = ((viewBlock, editBlock, showView, showEdit)->
			div.append($('<h3>').text('Info'))
			viewBlock = ((me, div, title, subtitle, abstract, editBtn)->
				div = $('<div>')
				title = $('<span>')
				subtitle = $('<span>')
				abstract = $('<span>')
				editBtn = $('<button>Edit</button>').click () -> showEdit()
				div
					.append('<b>Title:</b> ').append(title)
					.append('<br>')
					.append('<b>Subtitle:</b> ').append(subtitle)
					.append('<br>')
					.append('<b>Abstract:</b> ').append(abstract)
					.append('<br>')
					.append(editBtn)
				me = {
					div: div
					show: ->
						if id && currInfo
							title.text(currInfo.title)
							subtitle.text(currInfo.subtitle)
							abstract.text(currInfo.abstract)
							div.show()
						else div.hide()
					hide: ->
						div.hide()
				}
			)()
			editBlock = ((me, div, title, subtitle, abstract, dir, saveBtn, cancelBtn)->
				div = $('<div>')
				title = $('<input type="text">').width('100%')
				subtitle = $('<input type="text">').width('100%')
				abstract = $('<textarea>').width('100%')
				dir = $('<input type="checkbox">').width('100%')
				saveBtn = $('<button>Save</button>').click () ->
					currInfo.title = title.val()
					currInfo.subtitle = subtitle.val()
					currInfo.abstract = abstract.val()
					currInfo.dir = if dir.attr("checked") then true else false
					#alert(JSON.stringify(currInfo))
					saveInfo id, currInfo, (result)->
					#	alert(JSON.stringify result)
					showView()
				cancelBtn = $('<button>Cancel</button>').click () -> showView()
				div
					.append('<b>Title:</b> ').append(title)
					.append('<br>')
					.append('<b>Subtitle:</b> ').append(subtitle)
					.append('<br>')
					.append('<b>Abstract:</b> ').append(abstract)
					.append('<br>')
					.append('<b>Directory:</b> ').append(dir)
					.append('<br>')
					.append(saveBtn).append(cancelBtn)
				me = {
					div: div
					show: ->
						if id && currInfo
							title.val(currInfo.title)
							subtitle.val(currInfo.subtitle)
							abstract.val(currInfo.abstract)
							if currInfo.dir then dir.attr('checked', 'checked') else dir.removeAttr('checked')
							div.show()
						else div.hide()
					hide: ->
						div.hide()
				}
			)()
			div.append(viewBlock.div).append(editBlock.div)
			showView = ->
				viewBlock.show()
				editBlock.hide()
			showEdit = ->
				viewBlock.hide()
				editBlock.show()
			#showView()
			{
				showView: showView
			}
		)()
		me = {
			render: (info) -> 
				currInfo = info
				panel.showView()
				null
			load: (_id) ->
				id = _id
				if id
					loadInfo id, (info) -> me.render info
					div.show()
				else
					div.hide()
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
					new_doc id, {
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
			CB = ((me={}, list)->
				list = []
				me.add = (v)->
					((cb)->
						cb = $('<input type="checkbox">')
						list.push({elm: cb, data: v.data})
						$('<li>').append(cb).append(
							if(v.onClick)
								$('<a href="#">').text(v.title).click (e)->
									e.preventDefault()
									v.onClick(e)
							else $('<span>').text(v.title)
						)
					)()
				me.selectAll = -> $.each list, (k,v)-> v.elm.attr("checked","checked")
				me.deselectAll = -> $.each list, (k,v)-> v.elm.removeAttr("checked")
				me.clearList = ->
					list = []
					null
				me.getSelected = ->
					((rez=[])->
						$.each list, (k,v) ->
							rez.push(v.data) if v.elm.attr('checked')
						rez
					)()
				me
			)
			importBlock = ((cbList, selectPanel)->
				cbList = CB()
				selectPanel = ((tbody, td1, td2, listDiv, me)->
					importDiv.append(
						'<i>Import papers from conferences</i><br>'
					).append( $('<table>').append( tbody=$('<tbody>') ) )
					.append(
						#$('<button>Cancel</button>').click () -> showStd()
						$('<button>Hide import panel</button>').click () -> showStd()
					).append(
						$('<button>Import checked</button>').click () ->
							#alert(JSON.stringify cbList.getSelected())
							importConfPapers id, cbList.getSelected(), (result)->
								notifier.notify('changed', id)
								#alert(JSON.stringify result)
					)
					tbody.append( td1=$('<td valign="top">') )
					tbody.append( td2=$('<td valign="top">') )
					listDiv = $('<div>')
					td2.append( $('<input type="checkbox">').change( (e)->
						if $(e.target).attr('checked') then cbList.selectAll()
						else cbList.deselectAll()
					)).append('<b>Select/Deselect all</b>').append(listDiv)
					listDiv.css('overflow', 'scroll').css('height', '250pt')
					me = {
						renderConfs: (list) ->
							td1.empty()
							$.each list, (k, v)->
								$('<li>').append($('<a href="#">').click( (e)->
									e.preventDefault()
									loadConfPapersList v.contid, (list)-> me.renderPapers list
								).text(v.title)).appendTo(td1)
						renderPapers: (list) ->
							listDiv.empty()
							cbList.clearList()
							$.each list, (k, v)->
								#elm = CB(v)
								#elm = cbList.add(v)
								elm = cbList.add({
									title: v.authors+' | '+v.title,
									data: {context: v.context, papnum: v.papnum}
								})
								listDiv.append(elm)
					}
				)()
				{
					load: ->
						loadConfsList (result)->
							#alert JSON.stringify result
							selectPanel.renderConfs result
				}
			)()
			childrenList = ((cbList, ul, div)->
				cbList = CB()
				div = $('<div>')
				listDiv
					.append('<br>')
					.append('<i>Children list</i>')
					.append('<br>')
					.append( $('<input type="checkbox">').change( (e)->
						if $(e.target).attr('checked') then cbList.selectAll()
						else cbList.deselectAll()
					)).append('<b>Select/Deselect all</b>')
					.append(div)
					.append(
						$('<button>Delete checked</button>').click () ->
							alert(JSON.stringify cbList.getSelected())
							removeDocs cbList.getSelected(), (result)->
								notifier.notify('changed', id)
					)
				div.css('overflow', 'scroll').css('height', '250pt')
				{
					render: (list) ->
						div.empty()
						cbList.clearList()
						$.each list, (k, v)->
							cbList.add({
								title: v.info.title,
								data: {_id: v._id},
								onClick: (e)->
								#	e.preventDefault()
									notifier.notify('changed', v._id)
						
							}).appendTo(div)
						#	$('<li>').append($('<a href="#">').click( (e)->
						#		#e.preventDefault()
						#		notifier.notify('changed', v._id)
						#	).text(v.info.title)).appendTo(div)
				}
			)()
			showStd()
			{
				renderChildren: (list) ->
					showStd()
					childrenList.render list
			}
		)()
		me = {
			load: (_id) ->
				id = _id
				loadChildren id, (children) ->
					panel.renderChildren children
				null
		}
		me
	)()
	DocPage = (-> (container) ->
		pageDiv = $('<div></div>').appendTo container
		pathDiv = $('<div></div>').appendTo( pageDiv.append($('<div>')) )
		infoDiv = $('<div></div>').appendTo( pageDiv )
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


