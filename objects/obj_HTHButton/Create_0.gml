sprite_index = spr_BlankTM;
width = 256;
height = 64;

text = "How To Host"

var ypos = obj_Title.top + obj_Title.button_spacing*5;

y = ypos;
x = view_wport[0]/2;

draw_set_font(global.fntsize3);
draw_set_halign(fa_center);
image_xscale = string_width(text)/64
image_yscale = string_height(text)/64;