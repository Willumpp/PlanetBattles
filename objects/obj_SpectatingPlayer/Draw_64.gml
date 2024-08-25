//Show the player name of who you are spectating
if obj_Player.dead == true and instance_exists(obj_Player.spec_inst) {
	draw_set_font(fnt_Nasalization24);
	draw_set_halign(fa_right);
	draw_text(view_wport[0]-8, 64, "Spectating Player: "+string(obj_Player.spec_inst.username));
}