timer -= global.dt;
//fraction = (total_time-timer)/total_time
direction = image_angle;

if timer < 0 {
	instance_destroy()	
}

//Damage players
var _coll = scr_ObjectCollision(x, y, obj_Player, "");
if _coll != undefined and instance_exists(_coll) {
	_coll.set_health(_coll.hlth-damage);	
}
/*
with obj_Player {
	if place_meeting(x, y, other.id) {
		set_health(hlth-other.damage);
	}
}