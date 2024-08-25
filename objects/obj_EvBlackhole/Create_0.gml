/// @description Insert description here


// Inherit the parent event
event_inherited();
warning_text = "Black hole"

sound_playing = false
audio_emitter = audio_emitter_create();
scale = image_xscale;
destroy_distance = 100; //Distance from object until destruction
expansion_cooldown = 0.3;
psuction_cooldown = 0.3;


parTypeWormhole = part_type_create();
var _parfactor = 30
_const = _parfactor / (2*pi*48);

var _col = irandom_range(0, 2);
var _roff = irandom_range(0,50);
var _goff = irandom_range(0,50);
var _boff = irandom_range(0,50);
switch _col {
	case 0:
		colour = make_color_rgb(_roff, 255-_goff, 255-_boff);
		break;
	case 1:
		colour = make_color_rgb(255-_roff, _goff, 255-_boff);
		break;
	case 2:
		colour = make_color_rgb(255-_roff, 255-_goff, _boff);
		break;
}
colour = make_color_hsv(color_get_hue(colour), color_get_saturation(colour)*0.75,
								color_get_value(colour));
_colt = make_color_rgb(255-color_get_red(colour)/2, 255-color_get_green(colour)/2, 255-color_get_blue(colour)/2)
_par_angle = 0;


function set_intensity(val) {
	intensity = val/4;
	image_xscale = 0.15 * (room_width*room_height)/(1920*1080) * intensity
	image_yscale = image_xscale;
	scale = image_xscale;
}


function warning_end() {
	var count = 50;
	var n = 0;
	var rad = 1500*image_xscale*0.5
	
	repeat(count+1) {
		var _ang = n
		var _xoff = rad * cos(_ang*pi/180);
		var _yoff = rad * sin(_ang*pi/180);
		
		parStream(parTypeWormhole, _colt, colour, n, 0.5, 5, 100);
		parCreate(global.parSys, x+_xoff, y-_yoff, parTypeWormhole, 1);
		n += 360/count
	}
	
	var _objs = tag_get_asset_ids("pullable", asset_object);
	for (var i = 0; i < array_length(_objs); i++) {
			
		var _obj = _objs[i];
		
		with _obj {
			//var _mag = (50/power(point_distance(x, y, other.x, other.y), 0.5));
			var _mag = 50;
			var _dir = point_direction(x, y, other.x, other.y);
			velocity[0] = -_mag * cos(_dir*pi/180);
			velocity[1] = _mag * sin(_dir*pi/180);
			
		}
	}
}
