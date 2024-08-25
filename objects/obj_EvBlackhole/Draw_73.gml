if state == evstate.active and sprite_exists(sprite_index) {
	//draw_self();	
	draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, image_angle, _colt, 1);
}