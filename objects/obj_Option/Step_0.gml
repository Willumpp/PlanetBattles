if scr_ButtonPress() {
	selected += 1;
	global.options_changed = true;
	
	if selected >= ds_list_size(display) {
		selected = 0;	
	}
	
	obj_GameOptionsMenu.moptions[? option_name][? "selected"] = selected;
}