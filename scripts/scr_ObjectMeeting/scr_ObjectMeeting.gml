// Detects a collision
//	returns object
function scr_ObjectMeeting(x, y, obj){
	//Loop through all objects checking for a collision
	//	return object if found
	for (var i = 0; i < instance_number(obj); i++) {
		var _obj = instance_find(obj, i);
		
		if position_meeting(x, y, _obj) {
			return _obj;	
		}
	}
	
	return undefined
	
}