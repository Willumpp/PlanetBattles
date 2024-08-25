scr_FocusLayer("MainMenu")

utexW = shader_get_uniform(shGlow, "texW");
utexH = shader_get_uniform(shGlow, "texH");

texW = texture_get_texel_width(sprite_get_texture(sprite_index, 0));
texH = texture_get_texel_height(sprite_get_texture(sprite_index, 0));


x = view_wport[0]/2;
y = view_hport[0]/2 - 284*global.scscale;
global.username2 = "Player2";
global.ship_type2 = st.red;	


//
//Particle types
//
try {
	part_system_destroy(global.parSys);
	global.parSys = part_system_create();
	part_system_destroy(global.parSys2);
	global.parSys2 = part_system_create();
}
catch (_exception) {
	global.parSys = part_system_create();
	global.parSys2 = part_system_create();
}

//Used for centering buttons in main menu
button_count = 6;
//button_spacing = ((y+sprite_height+128)-(128-view_hport[0]))/button_count;
button_spacing = (view_hport[0]/2)/button_count;
top = view_hport[0]/2 - 128*global.scscale;

audio_listener_position(1920/2, 1080/2, 0)
