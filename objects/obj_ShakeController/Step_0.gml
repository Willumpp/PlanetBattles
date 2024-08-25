if do_shake == true {
	//camera_set_view_pos(view_camera[0], view_x+random_range(-range, range), view_y+random_range(-range, range))	
	camera_set_view_angle(view_camera[0], random_range(-range, range));
}
else {
	//camera_set_view_pos(view_camera[0], view_x, view_y);	
	camera_set_view_angle(view_camera[0], 0);
}