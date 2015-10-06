Object::setAttr = (key, value, fun) ->
	this[key] = if fun? then fun value else value
Object::clone = (obj) ->
	obj = this if not arguments.length
	return obj if obj is null or typeof (obj) isnt "object"

	ret = if obj.instanceOf(Array) then (obj.map (e) -> e)
	else
		new obj.constructor?() ? Object.create obj.__proto__

	for key of obj
		ret[key] = obj.clone obj[key] if (obj.hasOwnProperty key) and key.match /[0-9]+/
	ret
Object::instanceOf = (objectC) ->
	this instanceof objectC || this.constructor == objectC
