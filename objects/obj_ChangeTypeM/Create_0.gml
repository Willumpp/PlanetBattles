y = view_hport[0] - 48;
x = 128;

draw_set_font(fnt_Nasalization24);
draw_set_halign(fa_left);
text = "Change Type"

ship_display = instance_create_layer(x + (string_width(text))/4,y - 72,"WinLoss",obj_ShipDisplay);
ship_display.change_type(global.ship_type1);

//Sprite work
sprite_index = spr_BlankTM;

image_xscale = string_width(text)/64
image_yscale = string_height(text)/64;

