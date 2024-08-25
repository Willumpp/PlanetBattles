
if mouse_check_button_pressed(mb_left) {
	selected = (position_meeting(mouse_x, mouse_y, id) == true);
}

allowed = false

if keyboard_check_pressed(vk_backspace) and selected == true  and string_length(text) > 0 {
	text = string_copy(text, 0, string_length(text)-1);	
	keyboard_string = "";
}
if keyboard_check_pressed(vk_anykey) and selected == true and string_length(text) < 8 {
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