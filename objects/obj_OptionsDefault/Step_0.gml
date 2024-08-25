if scr_ButtonPress() {
	var _map = json_decode(obj_GameOptionsMenu.def_options);
	scr_SaveJSON("gameoptions.txt", _map);
	ds_map_destroy(_map);
	game_restart();
}