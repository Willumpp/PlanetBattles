sprite_index = spr_BlankTL;

y = view_hport[0] - 64 * global.scscale;
x = 128 * global.scscale;

draw_set_font(fnt_Nasalization24);
draw_set_halign(fa_left);
image_xscale = string_width("Back")/64
image_yscale = string_height("Back")/64;

