width = 256 - 2*8;
height = 256 - 2*8

function draw_player(player, xpos, ypos, angle) {
	//Draw a mini player on the map, position is relative to the room size
	
	if player != undefined and player.dead == false {
		
		var dot_colour = scr_GetColour(player.ship_type);
		draw_sprite_ext(spr_MapPlayer, 0, xpos/room_width*width +x, ypos/room_height*width +y, 1, 1, angle, dot_colour, 1);
		//draw_circle(, , 5, false);
	}	
}

function draw_object(xpos, ypos, angle, sprite) {
	draw_sprite_ext(sprite, 0, xpos/room_width*width +x, ypos/room_height*width +y, 1, 1, angle, c_white, 1);
}
function draw_object_ext(xpos, ypos, angle, sprite, col) {
	draw_sprite_ext(sprite, 0, xpos/room_width*width +x, ypos/room_height*width +y, 1, 1, angle, col, 1);
}

draw_list = ds_list_create(); //Draw list for playres
//draw_list_objects = ds_list_create(); //Draw list of other objects

x = view_wport[0]-sprite_width+11; //+11 so flush with window
y = view_hport[0]-sprite_height+11;

parent = undefined;
broadcast_cooldown = 0;