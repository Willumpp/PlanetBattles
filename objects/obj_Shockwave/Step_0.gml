if player != undefined {
	x = player.x;
	y = player.y;
}

if expansion < 1 {
	expansion += expansion_speed;
	image_xscale = expansion;
	image_yscale = expansion;
}
else if player != undefined {
	ds_list_destroy(players_entered);
	instance_destroy();	
}

//Check for collisions with players
//var _obj = scr_ObjectCollision(x, y, obj_Player, "");

//Loop through all players checking for a collision
//	check if the player has already been shocked
//		if not, damage the player
//		if so, ignore the player
for (var i = 0; i < instance_number(obj_Player); i++) {
	var _obj = instance_find(obj_Player, i);
	
	if place_meeting(x, y, _obj) and _obj != player {
		var player_attacked = false;
		
		//Check if player was already damaged
		for (var i = 0; i < ds_list_size(players_entered); i++ ) {
			if ds_list_find_value(players_entered, i) == _obj { player_attacked = true; }
		}
		
		//Set the player if not already damaged
		if player_attacked == false {
			//Attack if player has not already been damaged
			_obj.set_health(_obj.hlth-damage);
			ds_list_add(players_entered, _obj);

		}
	}
}
