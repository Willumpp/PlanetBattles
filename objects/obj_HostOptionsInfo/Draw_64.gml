draw_self();

if menu_visible and visible {
	draw_set_color(c_black);
	draw_rectangle(64*sc, 64*sc, view_wport[0]-64*sc, view_hport[0]-64*sc, false);
	draw_set_color(c_white);
	draw_rectangle(64*sc, 64*sc, view_wport[0]-64*sc, view_hport[0]-64*sc, true)
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(fnt_Nasalization18);
	draw_text(view_wport[0]/2, view_hport[0]/2, text);
	draw_set_valign(fa_top)

}