draw_set_font(fnt_Nasalization12);

//background
if in_lobby {
	draw_rectangle_color(0,0,width, height, c_black, c_black, c_black, c_black, c_black);	
	
	//press enter message
	draw_set_halign(fa_center);
	if game_host {
		draw_text(width/2, height/2, "Press ENTER to force start");
	}
	else {
		draw_text(width/2, height/2, "Waiting for host to start");
	}
	
	//player count
	draw_set_halign(fa_right);
	draw_text(width-8, 8, "Players connected: "+string(ds_map_size(obj_Player.socket_map)));
}

//voting count
if instance_exists(obj_Ready) {
	with obj_Ready {
		draw_set_font(fnt_Nasalization12);
		draw_set_halign(fa_center);
		draw_text(x, y, "Vote Ready: "+string(votes));
		
	}
}	

