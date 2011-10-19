# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(document).ready ->
#$ ->
	window.RPC = (path) ->
		(method, data, ok_fun, err_fun) ->
			$.ajax
				url: path
				contentType: 'application/json'
			#	data: JSON.stringify(data)
			#	data: escape(JSON.stringify({method: method, params: data}))
				data: JSON.stringify({method: method, params: data})
				dataType: 'json'
				processData: false
			#	processData: true
				type: 'POST'
				success: ok_fun

	window.rpc = window.RPC('/rpc')

