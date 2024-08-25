/// @description Insert description here


// Inherit the parent event
event_inherited();
warning_text = "Wormhole"
warning_duration = 0;
enable_duration = false;
worm_colour = c_white;

var _col = irandom_range(0, 2);
var _roff = irandom_range(0,50);
var _goff = irandom_range(0,50);
var _boff = irandom_range(0,50);
switch _col {
	case 0:
		worm_colour = make_color_rgb(_roff, 255-_goff, 255-_boff);
		break;
	case 1:
		worm_colour = make_color_rgb(255-_roff, _goff, 255-_boff);
		break;
	case 2:
		worm_colour = make_color_rgb(255-_roff, 255-_goff, _boff);
		break;
}
worm_colour = make_color_hsv(color_get_hue(worm_colour), color_get_saturation(worm_colour)*0.75,
								color_get_value(worm_colour));
worm_colour2 = c_white;

var _col = irandom_range(0, 2);
var _roff = irandom_range(0,50);
var _goff = irandom_range(0,50);
var _boff = irandom_range(0,50);
switch _col {
	case 0:
		worm_colour2 = make_color_rgb(_roff, 255-_goff, 255-_boff);
		break;
	case 1:
		worm_colour2 = make_color_rgb(255-_roff, _goff, 255-_boff);
		break;
	case 2:
		worm_colour2 = make_color_rgb(255-_roff, 255-_goff, _boff);
		break;
}
worm_colour2 = make_color_hsv(color_get_hue(worm_colour2), color_get_saturation(worm_colour2)*0.75,
								color_get_value(worm_colour2));

function warning_end() {
	seed = my_random(seed, 10);
	var _arg1 = seed/10;
	seed = my_random(seed, 10);
	var _arg2 = seed/10;
	 
	var _inst1 = instance_create_layer(x, y, "Players", obj_Wormhole);
	var _inst2 = instance_create_layer(x, y, "Players", obj_Wormhole);
	
	repeat (20) { seed = my_random(seed, 10); }
	
	with _inst1 {
		colour = other.worm_colour;
		colour2 = other.worm_colour2;
		partner = _inst2;
		parent = other.id;
		
		if other.quadrant == quad.nw {
			x = room_width/2 * _arg1;
			y = room_height/2 * _arg2;
		}
		if other.quadrant == quad.ne {
			x = room_width - (room_width/2 * _arg1);
			y = room_height/2 * _arg2;
		}
		if other.quadrant == quad.se {
			x = room_width - (room_width/2 * _arg1);
			y = room_height - (room_height/2 * _arg2);
		}
		if other.quadrant == quad.sw {
			x = room_width/2 * _arg1;
			y = room_height - (room_height/2 * _arg2);
		}
		
	}
	
	seed = my_random(seed, 10);
	_arg1 = seed/10;
	seed = my_random(seed, 10);
	_arg2 = seed/10;
	
	with _inst2 {
		colour = other.worm_colour
		colour2 = other.worm_colour2
		partner = _inst1;
		parent = other.id;
		
		if other.quadrant == quad.se {
			x = room_width/2 * _arg1;
			y = room_height/2 * _arg2;
		}
		if other.quadrant == quad.sw {
			x = room_width - (room_width/2 * _arg1);
			y = room_height/2 * _arg2;
		}
		if other.quadrant == quad.nw {
			x = room_width - (room_width/2 * _arg1);
			y = room_height - (room_height/2 * _arg2);
		}
		if other.quadrant == quad.ne {
			x = room_width/2 * _arg1;
			y = room_height - (room_height/2 * _arg2);
		}
			
	}
		
}