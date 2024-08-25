// Text manipulation and string manipulation of inputted characters.
function scr_TextEntry(max_length){
	/*
	if mouse_check_button_pressed(mb_left) {
		selected = (position_meeting(mouse_x, mouse_y, id) == true);
	}
	*/
	if mouse_check_button_pressed(mb_left) {
		selected = scr_ButtonPress();
	}

	allowed = false

	if ((keyboard_check(vk_backspace) and backspace_cooldown < 0))
		and selected == true  and string_length(text) > 0 {
		text = string_copy(text, 0, string_length(text)-1);	
		keyboard_string = "";
		backspace_cooldown = 0.1
	}
	if backspace_cooldown >= 0 {
		backspace_cooldown -= global.dt;	
	}
	if string_length(text) <= 0 {
		text = " ";
	}

	if keyboard_check_pressed(vk_anykey) and selected == true and string_length(text) < max_length {
		//Check if the character is legal
		for (var i = 0; i < string_length(allowed_characters); i++) {
			if keyboard_string == string_copy(allowed_characters, i, 1) {
				allowed = true;	
			}
		}
	
		//append to displayed text
		if allowed {
			text += keyboard_string;
		}
	
		keyboard_string = "";
	}
}