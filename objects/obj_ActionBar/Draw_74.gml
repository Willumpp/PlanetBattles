var colour = scr_GetColour(parent.ship_type);

//scr_PartBar(spr_CooldownBar, sprite_width*(1-fraction), sprite_height, colour);
//scr_PartBarExt(spr_CooldownBar, sprite_width*fraction_acount, sprite_height/2, colour, 52, 183);
//scr_PartBarExt(spr_ActionCooldownbar, 52, 130*(1-fraction), colour, 0, 138);

//This is so the cooldown is drawn from the bottom up
//	the -1 flips the sprte
//	cannot do w/h parameters negative
draw_sprite_part_ext(spr_ActionCooldownbar, 0, 0, 0, 52, 130*(1-fraction), 0, 138+130, 1, -1, colour, 1);

scr_PartBar(spr_CooldownBar, sprite_width*fraction_acount, sprite_height, colour);

for (var i = x; i < x+sprite_width; i += sprite_width/global.action_count) {
	draw_line(i, y, i, y+sprite_height);
	draw_line(i-1, y, i-1, y+sprite_height);
	draw_line(i+1, y, i+1, y+sprite_height);
}