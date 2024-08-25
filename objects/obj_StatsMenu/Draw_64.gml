draw_set_font(fnt_Nasalization24);
draw_set_halign(fa_center);

scr_TitleWithLines("Player Stats", scr_GetColour(global.ship_type1))

//Loop through all the option keys
var spacing  = (view_hport[0]/2)/(stlen)


for (var i = 0; i < stlen; i++) {
	//draw_text(view_wport[0]/2 - 128*global.scscale, spacing * i + 128*global.scscale, lstats[i]);
	//draw_text(view_wport[0]/2 + 128*global.scscale, spacing * i + 128*global.scscale, mstats[? lstats[i]]);
	draw_text(view_wport[0]/2, spacing * i + 256*global.scscale, lstats[i] + " : " + string(int64(mstats[? lstats[i]])));
	

}