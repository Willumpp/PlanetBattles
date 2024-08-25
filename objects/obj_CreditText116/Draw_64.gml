draw_set_font(fnt_Nasalization18);
draw_set_halign(fa_center);
draw_text(view_wport[0]/2, view_hport[0]/2-text_height/2, credit_text);

draw_set_font(fnt_Nasalization24);
scr_TitleWithLines("Credits", scr_GetColour(global.ship_type1));
