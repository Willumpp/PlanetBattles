if player != undefined and player.respawning == true {
	draw_set_font(fnt_Nasalization24);
	draw_set_halign(fa_center);
	//Cast to int64 so cant see d.p
	draw_text(view_wport[0]/2, view_hport[0]/2, "Time until respawn:"+string(int64(respawn_cooldown)));
	draw_text(view_wport[0]/2, view_hport[0]/2+48*global.scscale, "Lives left:"+string(player.lifes));
}