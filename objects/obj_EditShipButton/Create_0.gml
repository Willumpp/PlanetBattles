sprite_index = spr_BlankTM;
width = 256;
height = 64;
y = view_hport[0]/2 + (48*5)*global.scscale;
x = view_wport[0]/2;

draw_set_font(global.fntsize3);
draw_set_halign(fa_center);
image_xscale = string_width("Edit Ship")/64
image_yscale = string_height("Edit Ship")/64;