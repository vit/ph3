
s = JSON.stringify
	a: 'asd'
	b: 123
	c:
		d: 'ddd'

d = { a: 'asd', b: 123, c: {d: 'ddd'}}

window.RPC = (path) =>
	(data, ok_fun) ->
		$.ajax
			url: path
			data: JSON.stringify(data)
			dataType: 'json'
			processData: false
			type: 'POST'
			success: ok_fun

rpc = window.RPC('/rpc')
#rpc(d, ((ddd) -> {alert ddd}))
#rpc({a: 'b'}, (ddd) -> {alert ddd})

