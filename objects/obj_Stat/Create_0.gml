sprite_index = spr_BlankTM;
width = 256;
height = 64;
//y = view_hport[0] - 64 *global.scscale;
//x = 128*global.scscale ;

var ypos = obj_Title.top + obj_Title.button_spacing*4;

y = ypos;
x = view_wport[0]/2;

draw_set_font(global.fntsize3);
draw_set_halign(fa_center);
image_xscale = string_width("Stats")/64
image_yscale = string_height("Stats")/64;