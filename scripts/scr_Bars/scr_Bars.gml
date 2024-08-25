
//Draws a "tiled" version of a bar
//	pass it a square sprite and it would tile the bar in chunks
function scr_TiledBar(sprite, colour, total_bars, fraction, xdir, ydir) {
	
	for (var i = 0; i < floor(total_bars*fraction); i++) {
		draw_sprite_ext(sprite, 0, x+i*32*xdir, y+i*32*ydir, 1, 1, 0, colour, 1);
	}
}

//Draws a passed sprite but cut off
//	the sprite should be the full bar
//	a fraction of the bar is drawn
function scr_PartBar(sprite, sprw, sprh, colour) {
	draw_sprite_part_ext(sprite, 0, 0, 0, sprw, sprh, x, y, 1, 1, colour, 1);
}

function scr_PartBarExt(sprite, sprw, sprh, colour, xpos, ypos) {
	draw_sprite_part_ext(sprite, 0, 0, 0, sprw, sprh, xpos, ypos, 1, 1, colour, 1);
}

//Scales the bar
function scr_StretchBar(sprite, xscale, yscale, colour) {
	draw_sprite_ext(sprite, 0, x, y, xscale, yscale, 0, colour, 1);	
}