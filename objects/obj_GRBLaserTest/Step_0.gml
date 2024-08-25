//timer -= global.dt;
fraction = (total_time-timer)/total_time
image_angle += 1;
direction = image_angle;

//if timer < 0 {
	//instance_destroy()	
//}

//Damage players
with obj_Player {
	if place_meeting(x, y, other.id) and id != other.player {
		set_health(hlth-other.damage);
	}
}