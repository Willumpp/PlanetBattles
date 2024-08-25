if scr_ButtonPress() {
	var _inp = global.join_ip
	
	if string_pos(":", _inp) <= 0 {
		show_message("Invalid IP");
	}
	else {
		var _colonpos = string_pos(":", _inp);
		var _ip = string_copy(_inp, 2, _colonpos-2); //Substring to the colon, start at 2 to remove the space
		var _port = string_copy(_inp, _colonpos+1, string_length(_inp)+1-_colonpos); //Substring from the colon to the end of the string
		
		global.join_ip = _ip;		
		global.join_port = real(_port);
		
		room_goto(rm_Client);
	}
}