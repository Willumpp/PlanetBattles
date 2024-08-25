//draw_sprite(spr_TextEntry, 0, x,y);
xscale = 32 + (string_length(text)*8);
yscale = 32;
draw_sprite_stretched(spr_TextEntry, 0, x, y, xscale, yscale);
image_xscale = xscale/32;

draw_set_font(fnt_Nasalization12);
draw_text(x+4,y, text);	
