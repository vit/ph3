
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
        this.__observers[name].include(observer);
    },
    detach: function(name, observer){
        if( this.__observers[name] ) this.__observers[name].erase(observer);
    },
    notify: function(name){
        var args = [];
        for( var i=1; i < arguments.length; i++ )
            args.push(arguments[i]);
        if( this.__observers[name] ) this.__observers[name].each(function(observer){
            observer.apply(null, args);
        });
    }
};


