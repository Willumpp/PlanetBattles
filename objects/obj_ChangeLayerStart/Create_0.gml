if global.applied_ship_options == true {
	
	//Save the file
	obj_GameOptionsLoader.moptions[? "applied_ship_options"][? "selected"] = 0;
	scr_SaveJSON("gameoptions.txt", obj_GameOptionsLoader.moptions);
	obj_GameOptionsMenu.play_mode = "HostMultiplayer"
	scr_FocusLayer("GameOptions");
}