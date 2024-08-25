if player != undefined {
	direction = point_direction(x, y, player.x, player.y);
	speed = global.dt * 900;
}

//Check player collisions
var _coll = scr_TagCollision(x, y, "player")
if _coll != undefined {
	//Heal if touching owner
	if _coll == player {
		with _coll { set_health(hlth+44); }
	}
	//Damage player if not
	//else {
	//	with _coll { set_health(hlth-other.damage);	}
	//}
	
	instance_destroy()
}

image_angle += 1;