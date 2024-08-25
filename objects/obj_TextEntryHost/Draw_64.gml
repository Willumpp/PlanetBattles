//draw_sprite(spr_TextEntry, 0, x,y);
draw_set_font(fnt_Nasalization24);
draw_set_halign(fa_center);
draw_text(view_wport[0]/2, y-48, "Port to host on:")
draw_set_font(global.fntsize3);

xscale = (string_width(text+"  "));
yscale = string_height(text);

//draw_sprite_stretched(spr_TextEntry, 0, x, y, xscale, yscale);
image_xscale = xscale/32;
image_yscale = yscale/32;
DrawCollisionBox();

x = view_wport[0]/2 - xscale/2;

draw_set_font(global.fntsize3);
draw_set_halign(fa_left);
draw_text(x+4,y, text);


