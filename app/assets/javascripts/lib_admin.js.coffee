
$ ->
	window.rpc('test_method', [{a: 'b'}], (result) -> alert JSON.stringify(result))

