/*
for (var i = 0; i < array_length(draw_points); i++) {
	var pnts = draw_points[i];
	draw_line(pnts[0]*sc, pnts[1]*sc, pnts[2]*sc, pnts[3]*sc);
}
*/
//draw_sprite_ext(spr_HUD, 0, 0, 0, sc, sc, 0, c_white, 1);
draw_sprite_stretched(spr_HUD, 0, 0, 0, view_wport[0]*sc, view_hport[0]*sc)