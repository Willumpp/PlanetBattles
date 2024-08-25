draw_set_font(fnt_Nasalization12);

if player != undefined and instance_exists(player){
	if player.dead == false {
		x = player.x;
		y = player.y+player.sprite_height+8;
		draw_set_halign(fa_center);
		draw_text(x,y,player.username)
		
		//Draw health
		scr_PartBarExt(spr_HealthBar, 64*player.hlth/player.base_health, 
			8, scr_GetColour(player.ship_type), x-32, player.y+player.sprite_height+32);
	}
}