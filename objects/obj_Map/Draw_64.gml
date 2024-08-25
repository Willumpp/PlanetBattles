draw_sprite(sprite_index, 0, x, y);

draw_player(parent, parent.x, parent.y, parent.image_angle);


//Get every clients' position every x seconds
if broadcast_cooldown < 0 {
	broadcast_cooldown = 3;
	
	ds_list_clear(obj_Map.draw_list);
	//Use every client to write to list
	with (obj_Client) {
		ds_list_add(obj_Map.draw_list, [id, x, y, image_angle]);	
	}
}

//Draw the other players' last known positions using the new list
for (var i = 0; i < ds_list_size(draw_list); i++) {
	
	var element = ds_list_find_value(draw_list, i);
	if instance_exists(element[0]) and element[0] != undefined {
		draw_player(element[0], element[1], element[2], element[3]);
	}
}

//Draw ammo packs
with obj_AmmoPack {
	other.draw_object(x, y, 0, spr_MapAmmo);	
}
//Draw wormholes
with obj_Wormhole {
	other.draw_object_ext(x, y, 0, spr_MapWormhole, colour);	
}