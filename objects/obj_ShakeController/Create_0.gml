
do_shake = false;

view_x = camera_get_view_x(view_camera[0]);
view_y = camera_get_view_y(view_camera[0]);

function shake(magnitude, length) {
	do_shake = true;
	range = magnitude;
	alarm[0] = length;
}

range = 3;