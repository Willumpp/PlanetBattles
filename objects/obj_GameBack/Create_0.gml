//Local co-op escape
y = view_hport[0] - 64 * global.scscale;
x = view_wport[0]/2;

draw_set_font(fnt_Nasalization24);
draw_set_halign(fa_center);
image_xscale = string_width("Main Menu")/64
image_yscale = string_height("Main Menu")/64;