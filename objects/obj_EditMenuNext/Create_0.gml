sprite_index = spr_BlankTM;

y = view_hport[0] - 64 * global.scscale;
x = view_wport[0] - 128 * global.scscale;

text = "Next"


draw_set_font(fnt_Nasalization24);
draw_set_halign(fa_center);
image_xscale = string_width(text)/64
image_yscale = string_height(text)/64;
