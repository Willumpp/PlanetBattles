function death_scripts() {
	sprite_index = spr_Nosprite;
	visible = false;
	velocity[0] = 0;
	velocity[1] = 0;
	state = pstates.dead;
	
	parExplode(parTypeDeath, scr_GetColour(ship_type), 0.1, 0.5, 10);
	parCreate(global.parSys, x, y,parTypeDeath, 10);
	//shield_active = false;
	
	scr_PlayerChildrenCleanup();
}

function scr_Death() {
	obj_AudioController.sfx_play(sndShipExplosion, x, y);
	
	//Send death message to everyone
	//	hides the player for every client (as if it were dead)
	if is_client == true and dead == false {
		buffer_seek(client_buffer, buffer_seek_start, 0);
		buffer_write(client_buffer, buffer_u8, network.player_died);
		buffer_write(client_buffer, buffer_u8, network.toserver);
		network_send_packet(socket, client_buffer, buffer_tell(client_buffer));
	}
	else if dead == false {
		scr_IncreaseStat("Times Destroyed", 1);
	}
	spectate(0);
	
	dead = true;
	//Because only send win checks if the lives have depleated
	if lifes <= 1 {
		obj_PlayerManager.total_players -= 1;
	
		if is_client == false {
			obj_PlayerManager.check_win();
		}
	}
	else if lifes > 1 {
		lifes -= 1;	
		respawn_timer.respawn(3); //Because the timer now needs to know to respawn the player in x seconds
	}
	
	death_scripts()
}

function scr_RespawnDeath() {
	respawning = true;
	obj_AudioController.sfx_play(sndShipExplosion, x, y);
	
	//Send death message to everyone
	//	hides the player for every client (as if it were dead)
	if is_client == true and dead == false {
		buffer_seek(client_buffer, buffer_seek_start, 0);
		buffer_write(client_buffer, buffer_u8, network.respawn_death);
		buffer_write(client_buffer, buffer_u8, network.toserver);
		network_send_packet(socket, client_buffer, buffer_tell(client_buffer));
	}
	else if dead == false {
		scr_IncreaseStat("Times Destroyed", 1);
	}
	spectate(0);
	
	dead = true;
	
	if lifes > 1 {
		lifes -= 1;	
		if respawn_timer != undefined and instance_exists(respawn_timer) {
			respawn_timer.respawn(3); //Because the timer now needs to know to respawn the player in x seconds
		}
	}
	
	death_scripts()
}

//This respawns the player only if there are "lifes" left
//	dont spawn near another player
//	keep trying until successful
function scr_PlayerRespawn(max_dist) {
	scr_PlayerReset(); //Resets all relevant player variables so the player is seen again
	
	var valid = false;
	while !valid {
		valid = true;
		
		x = irandom_range(0, room_width);
		y = irandom_range(0, room_height);
		
		//Loop through clients
		var _obj;
		if instance_number(obj_Client) <= 0 {
			break;
		}
		for (var i = 0; i < instance_number(obj_Client)+1; i++) {
			_obj = instance_find(obj_Client, 0);
			//If near another player, find new pos
			if distance_to_point(_obj.x, _obj.y) < max_dist{
				valid = false;	
				break;
			}
		}
		
		//This is so you dont respawn in the black hole
		if instance_exists(obj_EvBlackhole) and distance_to_point(obj_EvBlackhole.x, obj_EvBlackhole.y) - obj_EvBlackhole.image_xscale*1566*0.5 < 900 {
			valid = false;	
		}
		
		
	}
	
	if is_client == true {
		buffer_seek(client_buffer, buffer_seek_start, 0);
		buffer_write(client_buffer, buffer_u8, network.player_respawn);
		buffer_write(client_buffer, buffer_u8, network.toserver);
	
		network_send_packet(socket, client_buffer, buffer_tell(client_buffer));	
	}
	respawning = false;
}