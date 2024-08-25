switch obj_Player.ship_type {
	case st.red:
		blend_colour = make_color_rgb(256 * quantity/10, 0, 0);
		break;
	case st.green:
		blend_colour = make_color_rgb(0, 256 * quantity/10, 0);
		break;
	case st.blue:
		blend_colour = make_color_rgb(0, 0, 256 * quantity/10);
		break;
}

draw_sprite_ext(sprite_index, 0, x, y, 1, 1, image_angle, blend_colour, 1);
//draw_self()