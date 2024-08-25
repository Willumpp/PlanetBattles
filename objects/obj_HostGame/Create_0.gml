sprite_index = spr_BlankTM;

y = view_hport[0]/2 + (48*1)*global.scscale;
x = view_wport[0]/2;

draw_set_font(fnt_Nasalization24);
draw_set_halign(fa_center);
image_xscale = string_width("Host Game")/64
image_yscale = string_height("Host Game")/64;

