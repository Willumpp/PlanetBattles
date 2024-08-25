//draw_sprite(spr_TextEntry, 0, x,y);
xscale = (string_width(text+"  "));
yscale = 32;

//draw_sprite_stretched(spr_TextEntry, 0, x, y, xscale, yscale);
image_xscale = xscale/64;
DrawCollisionBox();

x = view_wport[0]/2 - xscale/4;

draw_set_font(fnt_Nasalization12);
draw_set_halign(fa_left);
draw_text(x,y, text);	