/// @description Insert description here


// Inherit the parent event
event_inherited();

//Play the laser sound as long as its alive
/*
audio_emitter_position(audio_emitter, x, y, 0);
if sound_playing == false and state == evstate.active {
	sound_playing = true;
	audio_play_sound_on(audio_emitter, sndblackhole, true, 60);
}
*/

if state == evstate.active {
	if audio_is_playing(sndblackhole) == false {
		obj_AudioController.sfx_play_global(sndblackhole);	
	}

	
	_par_angle += 3;

	var count = _const * 1566 * image_xscale;
	var n = 0;
	var rad = 1500*image_xscale*0.5
	
	repeat(count+1) {
		var _ang = _par_angle+n
		var _xoff = rad * cos(_ang*pi/180);
		var _yoff = rad * sin(_ang*pi/180);
		
		if image_xscale <= 0.25 {
			parStream(parTypeWormhole, _colt, colour, _ang, 0.5, 0.1875*image_xscale/0.25 , 27*image_xscale/0.25);
		}
		else {
			parStream(parTypeWormhole, _colt, colour, _ang, 0.5, 0.1875 , 27);	
		}
		parCreate(global.parSys2, x+_xoff, y-_yoff, parTypeWormhole, 1);
		n += 360/count
	}
	
	
	
	if expansion_cooldown < 0 {
		image_xscale = abs(scale * (duration/45));
		image_yscale = image_xscale;
		destroy_distance = image_xscale * 700;
	}
	else {
		image_xscale = abs(scale * ((0.3 - expansion_cooldown)/0.3));
		image_yscale = image_xscale;
		expansion_cooldown -= global.dt
	}
	
	
	
	//Suck particles
	if psuction_cooldown < 0 {
		var rad = 1500*image_xscale*2
		var _ang = random_range(0,360)
		var _xoff = rad * cos(_ang*pi/180);
		var _yoff = rad * sin(_ang*pi/180);
		
		if image_xscale <= 0.25 {
			parStream(parTypeWormhole, _colt, colour, _ang-180, 0.5, 0.5*image_xscale/0.25 , 27);
		}
		else {
			parStream(parTypeWormhole, _colt, colour, _ang-180, 0.5, 1 , 27);	
		}
		parCreate(global.parSys2, x+_xoff, y-_yoff, parTypeWormhole, 1);
	}
	else {
		psuction_cooldown -= global.dt	
	}
	
	//Delete bullets
	var _coll = scr_TagCollision(x, y, "bullet")
	if _coll != undefined { //If colliding with an object
		instance_destroy(_coll);	
	}


	var _objs = tag_get_asset_ids("pullable", asset_object);
	for (var i = 0; i < array_length(_objs); i++) {
			
		var _obj = _objs[i];
		
		with _obj {
			var _dist = point_distance(x, y, other.x, other.y) - other.image_xscale*1566*0.5
			var _mag = clamp(power(1.01, -0.054*_dist)-0.6, 0.05, 0.5);
			
			var _dir = point_direction(x, y, other.x, other.y);
			velocity[0] += _mag * cos(_dir*pi/180);
			velocity[1] -= _mag * sin(_dir*pi/180);
			
			
			//Code depending on object
			switch object_index {
				case obj_Player:
					if point_distance(x, y, other.x, other.y) < other.destroy_distance and state != pstates.dead {
						set_health(-hlth);	
						other.duration += 0.25
					}
					break;
				default:
					if point_distance(x, y, other.x, other.y) < other.destroy_distance {
						instance_destroy();	
						other.duration += 0.25 * (sprite_width*sprite_height/16384)
					}
					break;
			}
		}
	}		
}
