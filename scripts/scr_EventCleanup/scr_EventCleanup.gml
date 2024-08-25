function scr_EventCleanup(){
	var _objs = tag_get_assets("event");

	for (var j = 0; j < array_length(_objs); j++) {
		var obj = _objs[j];
		
		//Convert if object
		if asset_get_type(obj) == asset_object { obj = asset_get_index(obj); }
		else { continue; }
		
		for (var i = 0; i < instance_number(obj); i++) {
			var _obj = instance_find(obj, i);
			with _obj {
				instance_destroy();	
			}
		}
	}
	
	return undefined;
}