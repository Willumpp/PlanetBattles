y = view_hport[0]/2;
backspace_cooldown = 0;

selected = false;
//need a try catch to retain the global
//	typing it again is annoying in game
try {
	text = string(global.host_port);
}
catch (_exception) {
	show_debug_message(_exception.message)
	global.host_port = "63425";
	text = global.host_port;
}
allowed_characters = "1234567890.::";