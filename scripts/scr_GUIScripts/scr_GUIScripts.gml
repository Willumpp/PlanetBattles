
function scr_TitleWithLines(title, colour) {
	var sc = global.scscale;
	draw_set_color(colour);
	draw_text(view_wport[0]/2, 32*sc, title); //Text
	var twidth = string_width(title);
	var theight = string_height(title);
	draw_line(0, theight/2+32*sc, view_wport[0]/2-twidth-128*sc, theight/2+32*sc); //Left line
	draw_line(view_wport[0]/2+twidth+128*sc, theight/2+32*sc, view_wport[0], theight/2+32*sc); //Right line
	draw_set_color(c_white);
}

function scr_IncreaseStat(stat, val) {
	global.mstats[? stat] += val;
}