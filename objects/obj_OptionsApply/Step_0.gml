if scr_ButtonPress() and global.options_changed == true {
	//Apply all the options
	//	uses the custom script
	with obj_Option {
		scr_ApplyOption(option_name, selected)	
	}
	
	obj_GameOptionsMenu.moptions[? "applied_ship_options"][? "selected"] = 0;
	
	//Save the file
	scr_SaveJSON("gameoptions.txt", obj_GameOptionsMenu.moptions);
	game_restart();
}