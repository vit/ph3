#

#$(document).ready ->
#$ -> ((box)->
((box)->
	#window.rpc 'aaacall', [], (data) ->
	#	alert(JSON.stringify(data))

	loadInfo = (id, callback) -> rpc 'lib.get_doc_info', [id], (res, err)-> callback res.result
	loadChildren = (id, callback) ->
		callback [
			{_id: 123, title: 'qwerty'},
			{_id: 321, title: 'assfghj'}
		]
	new_doc = (data, callback) -> rpc 'lib.new_doc', [data], (res, err)-> callback res.result

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
				viewTitle.text(currInfo.title)
				viewAbstract.text(currInfo.abstract)
				elm.show() for elm in viewElms
				elm.hide() for elm in editElms
			showEdit = ->
				editTitle.val(currInfo.title)
				editAbstract.val(currInfo.abstract)
				elm.hide() for elm in viewElms
				elm.show() for elm in editElms
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
			noAddDiv = $('<div>').appendTo div
			addDiv = $('<div>').appendTo div
			addTitle = $('<input type="text">').width('100%')
			addAbstract = $('<textarea>').width('100%')
			addBtn = $('<button>Add</button>').click () ->
				showAdd()
			saveBtn = $('<button>Save</button>').click () ->
				currInfo = {}
				currInfo.title = addTitle.val()
				currInfo.abstract = addAbstract.val()
				new_doc currInfo, (result) -> alert(JSON.stringify result)
				hideAdd()
				me.load id
			cancelBtn = $('<button>Cancel</button>').click () ->
				hideAdd()
			hideAdd = ->
				noAddDiv.show()
				addDiv.hide()
			showAdd = ->
				addDiv.show()
				noAddDiv.hide()
			noAddDiv.append(addBtn)
			addDiv.append('<i>Add new item</i><br>')
				.append('<b>Title:</b> ').append(addTitle)
				.append('<br>')
				.append('<b>Abstract:</b> ').append(addAbstract)
				.append('<br>')
				.append(saveBtn)
				.append(cancelBtn)
			hideAdd()
			{}
		)()
		ul = $('<ul>').appendTo(div)
		me = {
			render: (children) -> 
				ul.empty()
				for v in children
					$('<li>').appendTo(ul).text(v.title)
				null
			load: (_id) ->
				id = _id
				loadChildren id, (children) ->
					me.render children
				null
		}
		me
	)()
	DocPage = (-> (container) ->
		pageDiv = $('<div></div>').appendTo container
		infoDiv = $('<div></div>').appendTo( pageDiv.append($('<div>').append($('<h3>').text('Info'))) )
		childrenDiv = $('<div></div>').appendTo( pageDiv.append($('<div>').append($('<h3>').text('Children'))) )
		docInfo = new DocInfo(infoDiv)
		docChildren = new DocChildren(childrenDiv)
		{
			showDoc: (id) -> 
				#docInfo.render data.info
				docInfo.load id
				#docChildren.render data.children
				docChildren.load id
		}
	)()

	ipacs = {admin: {}}
	box.ipacs = ipacs
	ipacs.admin.Lib = (()->
		(container) ->
			docPage = new DocPage(container)
			docPage.showDoc(null)
	)()

)(window)


