
//Taking damage from bullets
var bullet = scr_TagCollision(x,y,"bullet");
if bullet != undefined and bullet.player != id and shield_active == false {
	var _dmg = bullet.damage;
	instance_destroy(bullet.id);
	set_health(hlth-_dmg);
	obj_ShakeController.shake(bullet.shake_factor, bullet.shake_length);
}
//This is for detecting if the shield is active to deflect the bullet
//acts the same as it did before but with a nice bouncing effect
else if bullet != undefined and bullet.player != id {
	var _dir = point_direction(bullet.x, bullet.y, x, y) + 180;
	var _mag = sqrt(sqr(bullet.velocity[0]) + sqr(bullet.velocity[1]));
	bullet.direction = _dir;
	bullet.image_angle = _dir;
	bullet.velocity[0] = _mag * cos(_dir*pi/180);
	bullet.velocity[1] = _mag * sin(_dir*pi/180);
	var _dmg = bullet.damage;
	set_health(hlth-_dmg);
}


if is_client == true and dead == false{
	multiplayer_movement()	
}
else if dead == false {
	singleplayer_movement()	
}


//Wall Collision
scr_WallCollision(mass);

//Asteroid/object collision
//now blue can push the asteroid instead
var _coll = scr_ObjectCollision(x+velocity[0], y+velocity[1], obj_Asteroid, "")
if _coll != undefined { //If colliding with an object
	if ship_type != st.blue {
		//Get direction to object
		var _dir = point_direction(_coll.x, _coll.y, x, y);
	
		//Create new velocity x and y component in response
		x_comp = mass * cos(_dir*pi/180)
		y_comp = mass * sin(_dir*pi/180)
		velocity[0] = x_comp 
		velocity[1] = -y_comp
	}
}


//Move
x += velocity[0]
y += velocity[1]	

//Send movement info of the client
if (is_client == true) {
	buffer_seek(client_buffer, buffer_seek_start, 0);
	buffer_write(client_buffer, buffer_u8, network.player_move);
	buffer_write(client_buffer, buffer_u8, network.toserver);
	buffer_write(client_buffer, buffer_s16, x);
	buffer_write(client_buffer, buffer_s16, y);
	buffer_write(client_buffer, buffer_s16, velocity[0]);
	buffer_write(client_buffer, buffer_s16, velocity[1]);
	buffer_write(client_buffer, buffer_s16, image_angle);

	//NOTE; "network_send_packet" does not send the packet directly to the socket
	//		it sends the data to the server with the socket id
	network_send_packet(socket, client_buffer, buffer_tell(client_buffer));
}

//Choose weapon
if keyboard_check_pressed(k_weapon1) {
	set_weapon(weapons.revolver)	
}
if keyboard_check_pressed(k_weapon2) {
	set_weapon(weapons.rifle)	
}
if keyboard_check_pressed(k_weapon3) {
	set_weapon(weapons.minigun)	
}

//
//Shooting
//
if shoot_condition(k_shoot) and keyboard_check(k_secondary) == false 
	and shoot_cooldown < 0  and dead == false {
	shoot_cooldown = shoot_speed;
	var _angle = bullet_anglefunc();
	var _xscale = bullet_xscale;
	var _yscale = bullet_yscale;
	
	//spd, dmg, sprite for creating a bullet
	var _spd = bullet_spd;
	bullet_func(_spd, damage, _angle, _xscale, _yscale, bullet_sound);
	
	scr_IncreaseStat("Shots Fired", 1);
	
	if (is_client == true) {
		buffer_seek(client_buffer, buffer_seek_start, 0);
		buffer_write(client_buffer, buffer_u8, network.fire_bullet);
		buffer_write(client_buffer, buffer_u8, network.toserver);
		buffer_write(client_buffer, buffer_u8, _spd);
		buffer_write(client_buffer, buffer_f16, damage);
		buffer_write(client_buffer, buffer_s16, _angle);
		buffer_write(client_buffer, buffer_f16, _xscale);
		buffer_write(client_buffer, buffer_f16, _yscale);
		buffer_write(client_buffer, buffer_u8, bullet_sound);
		
		network_send_packet(socket, client_buffer, buffer_tell(client_buffer));
	}
}
if shoot_cooldown >= 0 {
	shoot_cooldown -= global.dt;
}

//
//Action
//
if keyboard_check_pressed(k_action) and action_cooldown < 0 and action_active == false and dead == false
	and action_count > 0 {
		
	var _func = scr_GetSecondary(action_function);
	action_cooldown = 12;
	action_count -= 1;
	_func()
	scr_IncreaseStat("Abilities Used", 1);

	
	//Send info to server
	if is_client == true {
		buffer_seek(client_buffer, buffer_seek_start, 0);
		buffer_write(client_buffer, buffer_u8, network.use_secondary);
		buffer_write(client_buffer, buffer_u8, network.toserver);
		buffer_write(client_buffer, buffer_u8, action_function);
		
		network_send_packet(socket, client_buffer, buffer_tell(client_buffer));
	}
}
if action_cooldown >= 0 {
	action_cooldown -= global.dt;	
	if action_bar != undefined { action_bar.update_bar(); }
}

//
//Secondary action
//
//this is a "hold until released" system
//	or when heat runs out
if keyboard_check_pressed(k_secondary) and cooled = true and dead == false and ammo >= 0 {
	_destroyed_secondary = false;
	var sec = scr_GetSecondary(secondary_func);
	//heat += max_heat / 2;
	secondary_cooldown = 5;
	
	if is_client == true {
		
		sec();
		
		buffer_seek(client_buffer, buffer_seek_start, 0);
		buffer_write(client_buffer, buffer_u8, network.use_secondary);
		buffer_write(client_buffer, buffer_u8, network.toserver);
		buffer_write(client_buffer, buffer_u8, secondary_func);
		
		network_send_packet(socket, client_buffer, buffer_tell(client_buffer));
	}
	else {
		sec();	
	}
}
//Delete when released
if (keyboard_check_released(k_secondary) or ammo <= 0) and _destroyed_secondary == false  {
	_destroyed_secondary = true;
	
	var _obj = scr_GetSecondaryObject(secondary_func);
	with _obj {
		if player == other.id {
			instance_destroy();	
		}
	}
	
	if is_client == true {
		
		buffer_seek(client_buffer, buffer_seek_start, 0);
		buffer_write(client_buffer, buffer_u8, network.delete_secondary);
		buffer_write(client_buffer, buffer_u8, network.toserver);
		buffer_write(client_buffer, buffer_u8, secondary_func);
		
		network_send_packet(socket, client_buffer, buffer_tell(client_buffer));
	}
}
if secondary_cooldown >= 0 {
	secondary_cooldown -= global.dt;
}

if dead == true {
	spectate(spec_player);
	if keyboard_check_pressed(vk_right) {
		change_spec(1);	
	}
}

//
//Particles
//
parSelfTrail(parTypeTrail, 0.1, sprite_index);
parCreate(global.parSys, x, y,parTypeTrail, 1);
audio_listener_position(x, y, 0);
audio_emitter_position(obj_AudioController.sfx_emitter, x, y, 0);
