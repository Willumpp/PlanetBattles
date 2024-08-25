y = view_hport[0]/2 + 96;

backspace_cooldown = 0;

selected = false;
//need a try catch to retain the global
//	typing it again is annoying in game
try {
	text = global.username1;
}
catch (_exception) {
	show_debug_message(_exception.message)
	global.username1 = "Player1";
	text = global.username1;
}


allowed_characters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~  ";