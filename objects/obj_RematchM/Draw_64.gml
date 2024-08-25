//draw_sprite(spr_Rematch, 0, x, y);
var votes_required = ds_map_size(obj_Player.socket_map)
draw_set_font(fnt_Nasalization24);
draw_set_halign(fa_center);
draw_text(x, y, "Rematch: "+string(votes)+"/"+string(votes_required));
