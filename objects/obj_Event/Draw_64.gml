//Warning message
if state == evstate.warning and obj_Player.state != pstates.dead and _warning_fade < warning_duration*4*0.5 {
	//% 360 in case more than 2 flashes
	//abs for always positive
	//change the x*_warning_fade to change flash count
	var alpha = abs(sin((((180*_warning_fade)/(warning_duration/2))%360)*pi/180));
	draw_set_alpha(alpha);
	draw_set_font(fnt_Nasalization96);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);
	
	var ex = "North East"
	switch quadrant {
		case quad.ne:
			ex = "North East quadrant";
			break;
		case quad.nw:
			ex = "North West quadrant";
			break;
		case quad.sw:
			ex = "South West quadrant";
			break;
		case quad.se:
			ex = "South East quadrant";
			break;
		case quad.middle:
			ex = "the Centre";
			break;
		
	}
	
	draw_set_color(scr_GetColour(obj_Player.ship_type))
	draw_text(view_wport[0]/2, view_hport[0]/2, "WARNING");
	draw_set_font(fnt_Nasalization36);
	draw_text(view_wport[0]/2, view_hport[0]/2 + 128*global.scscale, warning_text + " in " + ex);
	draw_set_color(c_white)
	draw_set_valign(fa_top);
	draw_set_alpha(1);
}
if _warning_fade > warning_duration*4 and state = evstate.warning { 
	state = evstate.active
	warning_end()
}
