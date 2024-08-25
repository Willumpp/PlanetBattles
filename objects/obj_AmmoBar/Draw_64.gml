draw_set_font(fnt_Nasalization12);
draw_set_halign(fa_center);

//Determine if player 1 in order to reverse direcitons if not
var pl = ((player1==true) ? 1 : -1)

draw_text(x+16, y-32*pl, text);

//Draw energy or ammo, depending on the player type
/*
if parent.ship_type == st.red {
	scr_StretchBar(spr_Heat, 1, 10*fraction*pl, colour);
}
else {
	scr_TiledBar(spr_Ammo, colour, total_bars, fraction, 0, pl);
}
*/

if pl == 1 {
	scr_PartBar(spr_AmmoBar, (view_wport[0]-x)*fraction, sprite_height, scr_GetColour(parent.ship_type));
}
else {
	scr_PartBar(spr_AmmoBar, (view_wport[0]-sprite_width-x)*fraction, sprite_height, scr_GetColour(parent.ship_type));
}

//scr_PartBar(spr_AmmoBar, (view_wport[0]-x)*fraction, sprite_height, scr_GetColour(parent.ship_type));