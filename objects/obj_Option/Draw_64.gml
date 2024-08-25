draw_set_font(fnt_Nasalization24);
draw_set_halign(fa_left);
image_xscale = -string_width(display[| selected])/64
image_yscale = string_height(display[| selected])/64;
draw_text(x, y, display[| selected])

draw_set_halign(fa_right);
draw_text(view_wport[0]/2 - 128*global.scscale, y, option_name);