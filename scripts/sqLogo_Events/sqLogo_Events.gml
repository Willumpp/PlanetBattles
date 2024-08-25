// Auto-generated stubs for each available event.

function sqLogo_Moment()
{
	room_goto(MainMenu);
}



function sqLogo_Moment_1()
{
	window_center();
	global.enableglow = 0;
	obj_GameOptionsLoader.moptions[? "showed_warning"][? "selected"] = 1;
	scr_SaveJSON("gameoptions.txt", obj_GameOptionsLoader.moptions);
	
	if global.applied_ship_options == true and global.showed_warning == true {
		room_goto(MainMenu);
	}
}

