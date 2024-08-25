shoot_cooldown -= global.dt;


//Begin the shooting when the player is set
if shoot_cooldown < 0 and player != undefined {
	//Pick a random direction in a cone out from the player
	//var _dir = irandom_range(player.image_angle-15, player.image_angle+15);
	var _dir = player.image_angle;
	
	shots += 1;
	shoot_cooldown = 0.1;
	//We want to create the bullet at the end of the ship
	
	//Use the player to create a homing bullet
	with player {
		var xoffset = cos(_dir*pi/180) * sprite_width/2;
		var yoffset = sin(_dir*pi/180) * sprite_width/2;
	
		var _bullet = instance_create_layer(x+xoffset, y-yoffset, "Players", obj_Missile);
		_bullet.direction = _dir;
		_bullet.image_angle = _dir;
		_bullet.player = id;
		_bullet.colour = scr_GetColour(ship_type);
		_bullet.speed = bullet_spd/2;
	}
}
//Control shot count
if shots >= 1 { player.action_active = false; instance_destroy(); }