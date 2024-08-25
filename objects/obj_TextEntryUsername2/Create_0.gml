y = view_hport[0]/2 + 96;

selected = false;
//need a try catch to retain the global
//	typing it again is annoying in game
try {
	text = global.username2;
}
catch (_exception) {
	show_debug_message(_exception.message)
	global.username2 = "Player2";
	text = global.username2;
}
allowed_characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz 1234567890";