Object::properties = (  ) ->
	Object.getOwnPropertyNames this
Object::instanceOf = ( objectC ) ->
	this instanceof objectC || this.constructor == objectC
Object::getType = ( obj ) ->
	obj = this if not arguments.length
	if not obj? then "null"
	else if not (obj instanceof Object) then (typeof obj).charAt(0).toUpperCase() + (typeof obj).slice(1)
	else if obj.constructor? then obj.constructor.name
	else "Object"
Object::testIf = ( callback, defVal, args ) ->
	if callback.apply null, [this].concat(args) then this else defVal
Object::isEqual = ( obj, cmpW ) ->
	switch arguments.length
		when 0 then return false
		when 1 then cmpW = obj = this
	if ((typeof (obj) == "number" && isNaN(obj)) && (typeof (obj) == "number" && isNaN(cmpW)))
		return (true);
	if ((not obj? || not cmpW?) || (typeof (obj) != "object" || typeof (cmpW) != "object"))
		return (obj is cmpW);

	if (obj.constructor != cmpW.constructor)
		return (false);
	for attr of obj
		if (typeof (obj[attr]) != typeof (cmpW[attr]) || !(Object.isEqual(obj[attr], cmpW[attr])))
			return (false);
	true
Object::setAttr = ( key, value, fun ) ->
	this[key] = if fun? then fun value else value
Object::clone = ( obj ) ->
	obj = this if not arguments.length
	return obj if obj is null or typeof obj isnt "object"

	ret = if obj.instanceOf(Array) then (obj.map (e) -> e)
	else
		new obj.constructor?() ? Object.create obj.__proto__

	for key of obj
		ret[key] = obj.clone obj[key] if (obj.hasOwnProperty key) and key.match /[0-9]+/
	ret
Object::implement = ( r_obj, fun ) ->
	this.setAttr attr, r_obj[attr], fun for attr in r_obj when r_obj.hasOwnProperty(attr)
	this
Object::implementWeak = ( r_obj, fun ) ->
	this.setAttr attr, r_obj[attr], fun for attr in r_obj when r_obj.hasOwnProperty(attr) and typeof this[attr] == "undefined"
	this
