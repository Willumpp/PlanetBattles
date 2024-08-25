//timer -= global.dt;

/*
if timer < 0 or player.heat >= player.max_heat {
	instance_destroy()	
}
*/

//We want to create the bullet at the end of the ship
var xoffset = cos(player.image_angle*pi/180) * player.sprite_width/2;
var yoffset = sin(player.image_angle*pi/180) * player.sprite_width/2;
	
x = player.x + xoffset;
y = player.y - yoffset;

if player != undefined {
	image_angle = player.image_angle	
	direction = image_angle;
}

//This should increase the players heat as it goes
//player.heat += global.dt * 2;
with player {
	set_ammo(ammo - global.dt);
	
	//Particle create
	parPew(obj_PartController.parpew, scr_GetColour(ship_type), image_angle, 0.1, 0.75)
	parCreate(global.parSys, x+xoffset, y-yoffset, obj_PartController.parpew, 2);
}

//Damage players
with obj_Player {
	if place_meeting(x, y, other.id) and id != other.player {
		set_health(hlth-other.damage);
	}
}

//Play the laser sound as long as its alive
audio_emitter_position(audio_emitter, player.x, player.y, 0);
if sound_playing == false {
	sound_playing = true;
	audio_play_sound_on(audio_emitter, sndred_E, true, 60);
}

visible = true;