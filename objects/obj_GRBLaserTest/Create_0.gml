image_xscale = 5;
timer = 1;
total_time = timer;
fraction = 0
damage = 1.38;
player = undefined;
scale = random_range(0.5,1)

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
obj_AudioController.sfx_play(sndgrb2, x, y)