y = view_hport[0]/2 + 48;
x = view_wport[0]/2 + 240;

ship_display = instance_create_layer(x,y - 72,"EditShipMenu",obj_ShipDisplay);
try {
	ship_display.change_type(global.ship_type2)
}
catch (_exception) {
	global.ship_type2 = st.red;	
}

//Sprite work
sprite_index = spr_BlankTM;

draw_set_font(fnt_Nasalization24);
draw_set_halign(fa_center);
image_xscale = string_width("Change Type")/64
image_yscale = string_height("Change Type")/64;