// Detects a collision
//	returns object
//tag overrides the specified object
//	default : ""
function scr_ObjectCollision(x, y, obj, tag){
	if tag == "" {
		//Loop through all objects checking for a collision
		//	return object if found
		for (var i = 0; i < instance_number(obj); i++) {
			var _obj = instance_find(obj, i);
		
			if place_meeting(x, y, _obj) {
				return _obj;	
			}
		}
	}
	else {
		var _objs = tag_get_asset_ids(tag, asset_object);
		//Loop through all objects checking for a collision
		//	return object if found
		for (var i = 0; i < array_length(_objs); i++) {
			
			var _obj = _objs[i];
		
			if place_meeting(x, y, _obj) {
				return _obj;	
			}
		}	
	}
	
	return undefined
	
}

//Gets all the object indexes with that tag,
//	checks for a collision specifically
function scr_TagCollision(x, y, tag) {
	var _objs = tag_get_assets(tag);

	for (var j = 0; j < array_length(_objs); j++) {
		var obj = _objs[j];
		
		//Convert if object
		if asset_get_type(obj) == asset_object { obj = asset_get_index(obj); }
		else { continue; }
		
		//Loop through all objects checking for a collision
		//	return object if found
		for (var i = 0; i < instance_number(obj); i++) {
			var _obj = instance_find(obj, i);
			if place_meeting(x, y, _obj) {
				return _obj;	
			}
		}
	}
	
	return undefined;
}