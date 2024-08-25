y = view_hport[0]/2;
backspace_cooldown = 0;

selected = false;
//need a try catch to retain the global
//	typing it again is annoying in game
try {
	text = " "+global.join_ip +":"+string(global.join_port);
}
catch (_exception) {
	show_debug_message(_exception.message)
	global.join_ip = " 127.0.0.1:63425";
	text = global.join_ip;
}
allowed_characters = "SAM-1234567890.::";