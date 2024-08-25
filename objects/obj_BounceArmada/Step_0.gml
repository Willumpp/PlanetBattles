shoot_cooldown -= global.dt;

//This should increase the players heat as it goes
//player.heat += global.dt * 10;
with player {
	set_ammo(ammo - global.dt);	
}

//Begin the shooting when the player is set
if shoot_cooldown < 0 and player != undefined {
	shots += 1;
	shoot_cooldown = 0.1;
	
	for (var i = 0; i < 10; i++) {
		var _dir = irandom_range(0, 360);
	
	
		//We want to create the bullet at the end of the ship
	
		//Use the player to create a homing bullet
		with player {
			var xoffset = cos(-_dir*pi/180) * sprite_width/2;
			var yoffset = sin(-_dir*pi/180) * sprite_width/2;
	
			var _bullet = instance_create_layer(x+xoffset, y-yoffset, "Players", obj_BounceBullet);
			_bullet.direction = _dir;
			_bullet.image_angle = _dir;
			_bullet.velocity = [cos(_dir*pi/180) * 10, sin(_dir*pi/180) * 10];
			_bullet.player = id;
			_bullet.colour = scr_GetColour(ship_type);
		}
	}
}

//if shots > 10 { instance_destroy(); }
//if player.heat >= player.max_heat { instance_destroy(); }