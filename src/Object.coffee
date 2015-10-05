Object.prototype.setAttr = (key, value, fun) ->
	return this[key] = if fun? then fun(value) else value
Object.prototype.clone = (arg) ->
	return arg if arg?
	this
