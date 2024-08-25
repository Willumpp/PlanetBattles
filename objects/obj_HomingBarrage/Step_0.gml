shoot_cooldown -= global.dt;

//This should increase the players heat as it goes
//player.heat += global.dt * 6;
with player {
	set_ammo(ammo - global.dt);	
}

//Begin the shooting when the player is set
if shoot_cooldown < 0 and player != undefined {
	//Pick a random direction in a cone out from the player
	var _dir = irandom_range(player.image_angle-15, player.image_angle+15);
	shots += 1;
	shoot_cooldown = 0.1;
	
	//Play sound
	obj_AudioController.sfx_play(sndgreen_E, x, y);
	
	//Particle
	
	
	//We want to create the bullet at the end of the ship
	
	//Use the player to create a homing bullet
	with player {
		var xoffset = cos(_dir*pi/180) * sprite_width/2;
		var yoffset = sin(_dir*pi/180) * sprite_width/2;
		
		//Particle create
		parLaunch(obj_PartController.parlaunch, scr_GetColour(ship_type), _dir, 0.2, 0.75, 20)
		parCreate(global.parSys, x+xoffset, y-yoffset, obj_PartController.parlaunch, 1);
	
		var _bullet = instance_create_layer(x+xoffset, y-yoffset, "Players", obj_HomingBullet);
		_bullet.direction = _dir;
		_bullet.image_angle = _dir;
		//_bullet.velocity = [cos(_dir*pi/180) * 10, sin(_dir*pi/180) * 10];
		_bullet.player = id;
		_bullet.colour = scr_GetColour(ship_type);
		//_bullet.speed = bullet_spd/2;
		_bullet.spd = bullet_spd/2;
		
	}
}

//if shots > 10 { instance_destroy(); }
//if player.heat >= player.max_heat { instance_destroy(); }