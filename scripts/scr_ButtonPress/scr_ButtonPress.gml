//Alows for the mouse to click onto the collision box of the sprite
//	returns true when an object is clicked
//	only works if the object is visible on the layer
//	mouse coordinates is relative to screen
function scr_ButtonPress(){
	if mouse_check_button_pressed(mb_left) {

		//var one = position_meeting(window_mouse_get_x(), window_mouse_get_y(), id);
		//var two = point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), x-256/2, y, x+256/2, y+64)
		var three = position_meeting(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), id);
		if three and layer_get_visible(layer) == true {
			obj_AudioController.sfx_play_global(sndclick);
			return true
		}
	}
	return false
}