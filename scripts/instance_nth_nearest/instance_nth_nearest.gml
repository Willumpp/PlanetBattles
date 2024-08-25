/// 
//
//  Returns the id of the nth nearest instance of an object
//  to a given point or noone if none is found.
//
//      x,y       point coordinates, real
//      obj       object index (or all), real
//      n         proximity, real
//
/// GMLscripts.com/license
//
//my note: obviously this is half not my script
function instance_nth_nearest(tag,nth,except,max_distance){
	var nearest = undefined;
	
	var objects = tag_get_asset_ids("player", asset_object);
	nth = min(max(1,nth),array_length(objects));
	var list = ds_priority_create();

	//Check the distance fropm each object (excluding the "except")
	//	also check if its in the max distance
	for (var i = 0; i < array_length(objects); i++) {
		
		var _obj = objects[i];
		if instance_exists(_obj) and _obj != except and _obj.dead == false and _obj != player.id
			and distance_to_point(_obj.x,_obj.y) <= max_distance{
			ds_priority_add(list,_obj.id,distance_to_point(_obj.x,_obj.y));
		}
	}
	
	//Avoid returning if list contains no items
	if ds_priority_size(list) <= 0 { 
		ds_priority_destroy(list);
		return undefined; 
	}
	
	repeat (nth) nearest = ds_priority_delete_min(list);

	ds_priority_destroy(list);
 
	
	return nearest;
	
}