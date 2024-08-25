shoot_cooldown -= global.dt;

//This should increase the players heat as it goes
//player.heat += global.dt * 10;
with player {
	set_ammo(ammo - global.dt);	
}

//Begin the shooting when the player is set
if shoot_cooldown < 0 and player != undefined {
	shots += 1;
	shoot_cooldown = 0.0225;
	
	obj_AudioController.sfx_play(sndblue_E, x, y);
	
	//for (var i = 0; i < 1; i++) {

	//Use the player to create a homing bullet
	with player {
		
		//We want to create the bullet at the end of the ship
		//additionally vary if the bullet is made left or right
		//now disabled, this was to create the bullets in a straight tunnel
		/*
		var xoffset = cos(image_angle*pi/180) * sprite_width/2  
							+ cos((image_angle+90)*pi/180) * irandom_range(-sprite_width/2, sprite_width/2);
		var yoffset = sin(image_angle*pi/180) * sprite_width/2 
							+ sin((image_angle+90)*pi/180) * irandom_range(-sprite_width/2, sprite_width/2)
						//sin(-image_angle+90*pi/180) * irandom_range(-sprite_width/2, sprite_width/2);;
		*/
		//Create bullets in cone
		var xoffset = cos(image_angle*pi/180) * sprite_width/2
		var yoffset = sin(image_angle*pi/180) * sprite_width/2
		var _dir = random_range(image_angle-10,image_angle+10);
		var _scale = random_range(0.4,0.6);
					
		var _bullet = instance_create_layer(x+xoffset, y-yoffset, "Players", obj_BounceBullet);
		_bullet.direction = _dir;
		_bullet.image_angle = _dir;
		_bullet.image_xscale = _scale;
		_bullet.image_yscale = _scale;
		_bullet.velocity = [cos(_dir*pi/180) * 19.5, -sin(_dir*pi/180) * 19.5 ];
		_bullet.player = id;
		_bullet.damage = 6.4; //8.4 is the base dmg of red player (as of writing)
		_bullet.damage *= 1-(0.5-_scale); //This is so bigger bullets deal more damage
		_bullet.colour = scr_GetColour(ship_type);
		
		//Particle create
		parPew(obj_PartController.parpew, scr_GetColour(ship_type), _dir, 0.1, 0.75)
		parCreate(global.parSys, x+xoffset, y-yoffset, obj_PartController.parpew, 1);
	}
	//}
}

//if shots > 10 { instance_destroy(); }
//if player.heat >= player.max_heat { instance_destroy(); }