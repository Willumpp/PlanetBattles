sprite_index = spr_BlankTM;

y = view_hport[0] - 64 * global.scscale;
x = view_wport[0] - (string_width("Restore Default") + 16) * global.scscale;

draw_set_font(fnt_Nasalization24);
draw_set_halign(fa_left);
image_xscale = string_width("Restore Default")/64
image_yscale = string_height("Restore Default")/64;

