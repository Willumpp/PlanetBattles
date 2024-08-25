draw_set_font(fnt_Nasalization24);
draw_set_halign(fa_center);
if global.options_changed {
	draw_set_color(c_white)
}
else {
	draw_set_color(c_gray)
}
draw_text(x, y, "Apply");
draw_set_color(c_white)