
Mixin = function(target, from) {
    for(var name in from)
        if(name!='_init') target[name] = from[name];
    if(from._init) from._init.apply(target, []);
    return target;
};

Mixin.Observable = {
    _init: function(){
        this.__observers = {};
    },
    attach: function(name, observer){
        if( !this.__observers[name] ) this.__observers[name] = [];
        this.__observers[name].push(observer);
    },
    detach: function(name, observer){
        if( this.__observers[name] ) {
		var l = this.__observers[name].length;
		for (var i=0; i<l; i++)
			if (this.__observers[name][i]==observer) {
				this.__observers[name].splice(i, 1);
				break;
			}
	}
    },
    notify: function(name){
        var args = [];
        for( var i=1; i < arguments.length; i++ )
            args.push(arguments[i]);
        if( this.__observers[name] ) {
		var l = this.__observers[name].length;
		for (var i=0; i<l; i++)
			this.__observers[name][i].apply(null, args);
        };
    }
};


