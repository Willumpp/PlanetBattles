//draw_sprite(spr_Winner, 0, x, y);

//Draws the winner's name
draw_set_font(fnt_Nasalization96);
draw_set_halign(fa_center);
draw_text(x, y-32, "Game Over");

draw_set_font(fnt_Nasalization12);
draw_set_halign(fa_center);
//draw_text(x, y+116, "Winning player: " + winner_name);
draw_text(x, y + 148 + 56, "Winners:");

draw_text(x, y+228, obj_Player.username + " - " + string(obj_Player.win_count));
for (var i = 0; i < instance_number(obj_Client); i++) {
	var _client = instance_find(obj_Client, i);
	draw_text(x, y+228+24+i*24, _client.username + " - " + string(_client.win_count));
}