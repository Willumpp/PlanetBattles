/// @description Insert description here


// Inherit the parent event
event_inherited();
warning_text = "Gamma Ray Bursts"

//sound_playing = false
//audio_emitter = audio_emitter_create();

function set_intensity(val) {
	intensity = val * (room_width*room_height)/(1920*1080);
	argpnt_rate = 1/(intensity*10);	
}

laser_scale = sqrt(room_width*room_width + room_height*room_height);

function change_pnt() {
	for (var i = 0; i < intensity/10; i++) {
		seed = my_random(seed, 10);
		var _inst = instance_create_layer(x, y, "Players", obj_GRBLaser);
		var _arg = seed/10;

	
		with _inst {
			//image_angle = point_direction(x, y, room_width/2, room_height/2);	
			//image_xscale = other.laser_scale;

			if other.quadrant == quad.nw {
				x = 0;
				y = room_height * 0.75 * _arg;
				direction = point_direction(0, room_height/2, room_width/2, 0);	
			}
			if other.quadrant == quad.ne {
				x = room_width
				y = room_height * 0.75 * _arg;
				direction = point_direction(room_width, room_height/2, room_width/2, 0);
			}
			if other.quadrant == quad.se {
				x = room_width
				y = room_height - (room_height * 0.75 * _arg);
				direction = point_direction(room_width, room_height/2, room_width/2, room_height);
			}
			if other.quadrant == quad.sw {
				x = 0
				y = room_height - (room_height * 0.75 * _arg);
				direction = point_direction(0, room_height/2, room_width/2, room_height);
			}
			image_angle = direction;
		
		}
	}
}
