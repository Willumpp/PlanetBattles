function scr_ServerPacket(buffer, msgid, socket) {
	//moved socket, x, y
	switch(msgid) {
		case network.player_move:
			
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.player_move); //msgid
			buffer_write(server_buffer, buffer_u8, network.toclient); //destination type
			buffer_write(server_buffer, buffer_u8, socket); //socket
			buffer_write(server_buffer, buffer_s16, buffer_read(buffer, buffer_s16)); //x
			buffer_write(server_buffer, buffer_s16, buffer_read(buffer, buffer_s16)); //y
			buffer_write(server_buffer, buffer_s16, buffer_read(buffer, buffer_s16)); //velx
			buffer_write(server_buffer, buffer_s16, buffer_read(buffer, buffer_s16)); //vely
			buffer_write(server_buffer, buffer_s16, buffer_read(buffer, buffer_s16)); //rotation
			
			
			//send movement to all sockets except sender
			for (var i = 0; i < ds_list_size(socket_list); i++) {
				var _sock = ds_list_find_value(socket_list, i);

				if _sock != socket {
					network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				}	
			}
			
		
			break;
			
		case network.fire_bullet:
			
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.fire_bullet); //msgid
			buffer_write(server_buffer, buffer_u8, network.toclient); //destination type
			buffer_write(server_buffer, buffer_u8, socket); //socket
			buffer_write(server_buffer, buffer_f16, buffer_read(buffer, buffer_f16)); //dmg
			buffer_write(server_buffer, buffer_u8, buffer_read(buffer, buffer_u8)); //speed
			buffer_write(server_buffer, buffer_s16, buffer_read(buffer, buffer_s16)); //direction
			buffer_write(server_buffer, buffer_f16, buffer_read(buffer, buffer_f16)); //xscale
			buffer_write(server_buffer, buffer_f16, buffer_read(buffer, buffer_f16)); //yscale
			buffer_write(server_buffer, buffer_u8, buffer_read(buffer, buffer_u8)); //bullet sound
			//buffer_write(server_buffer, buffer_u8, buffer_read(buffer, buffer_u8)); //sprite
			
			//send movement to all sockets except sender
			for (var i = 0; i < ds_list_size(socket_list); i++) {
				var _sock = ds_list_find_value(socket_list, i);

				if _sock != socket {
					network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				}	
			}
			break;
			
		case network.create_asteroid:
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.create_asteroid); //msgid
			buffer_write(server_buffer, buffer_u8, network.toclient); //destination type
			buffer_write(server_buffer, buffer_s16, buffer_read(buffer, buffer_s16)); //x
			buffer_write(server_buffer, buffer_s16, buffer_read(buffer, buffer_s16)); //y
			buffer_write(server_buffer, buffer_u8, buffer_read(buffer, buffer_u8)); //speed
			buffer_write(server_buffer, buffer_s16, buffer_read(buffer, buffer_s16)); //direction
			buffer_write(server_buffer, buffer_u8, buffer_read(buffer, buffer_u8)); //scale
			
		
			//send movement to all sockets except sender
			for (var i = 0; i < ds_list_size(socket_list); i++) {
				var _sock = ds_list_find_value(socket_list, i);

				if _sock != socket {
					network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				}	
			}
			
			
			break;
		
		//Sends the create data of a player
		case network.set_player:		
		
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.set_player); //msgid
			buffer_write(server_buffer, buffer_u8, network.toclient); //destination type
			buffer_write(server_buffer, buffer_u8, socket); //socket
			buffer_write(server_buffer, buffer_u8, buffer_read(buffer, buffer_u8)); //ship type
			buffer_write(server_buffer, buffer_string, buffer_read(buffer, buffer_string)); //username
			buffer_write(server_buffer, buffer_u8, buffer_read(buffer, buffer_u8)); //serverstate
				
			//set the type of the newly joined player
			for (var i = 0; i < ds_list_size(socket_list); i++) {
				var _sock = ds_list_find_value(socket_list, i);

				if _sock != socket {
					network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				}	
			}
			
			//Apply the option information of the newly joined player
			//Dont change the options of the host playera
			var _obuff = global.opbuffer;
			//Send the option information back to the player
			network_send_packet(socket, _obuff, global.opbuffersize);
			
			break;
		
		case network.meteor_create:
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.meteor_create); //msgid
			buffer_write(server_buffer, buffer_u8, network.toclient); //destination type
			buffer_write(server_buffer, buffer_f16, buffer_read(buffer, buffer_f16)); //centre[0]
			buffer_write(server_buffer, buffer_f16, buffer_read(buffer, buffer_f16)); //centre[1]
			buffer_write(server_buffer, buffer_s16, buffer_read(buffer, buffer_s16)); //x
			buffer_write(server_buffer, buffer_s16, buffer_read(buffer, buffer_s16)); //y
			buffer_write(server_buffer, buffer_f16, buffer_read(buffer, buffer_f16)); //image_xscale
			buffer_write(server_buffer, buffer_f16, buffer_read(buffer, buffer_f16)); //velx
			buffer_write(server_buffer, buffer_f16, buffer_read(buffer, buffer_f16)); //vely
			buffer_write(server_buffer, buffer_u16, buffer_read(buffer, buffer_u16)); //clientid
			
			var len = buffer_read(buffer, buffer_u8);
			buffer_write(server_buffer, buffer_u8, len); //queue length
			
			for (var i = 0; i < len; i++) {
				var _x = buffer_read(buffer, buffer_f16);
				var _y = buffer_read(buffer, buffer_f16);
				buffer_write(server_buffer, buffer_f16, _x); //x
				buffer_write(server_buffer, buffer_f16, _y); //y
			}

				
			//set the type of the newly joined player
			for (var i = 0; i < ds_list_size(socket_list); i++) {
				var _sock = ds_list_find_value(socket_list, i);

				if _sock != socket {
					network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				}	
			}
			
			break;
			
			/*
		case network.meteor_move:
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.meteor_move); //msgid
			buffer_write(server_buffer, buffer_u8, network.toclient); //destination type
			buffer_write(server_buffer, buffer_s16, buffer_read(buffer, buffer_s16)); //offset[0]
			buffer_write(server_buffer, buffer_s16, buffer_read(buffer, buffer_s16)); //offset[1]
			buffer_write(server_buffer, buffer_s16, buffer_read(buffer, buffer_s16)); //vel[0]
			buffer_write(server_buffer, buffer_s16, buffer_read(buffer, buffer_s16)); //vel[1]
			buffer_write(server_buffer, buffer_u16, buffer_read(buffer, buffer_u16)); //clientid

				
			//set the type of the newly joined player
			for (var i = 0; i < ds_list_size(socket_list); i++) {
				var _sock = ds_list_find_value(socket_list, i);

				if _sock != socket {
					network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				}	
			}
			
			break;
			*/
			
		case network.meteor_move:
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.meteor_move); //msgid
			buffer_write(server_buffer, buffer_u8, network.toclient); //destination type
			
			var len = buffer_read(buffer, buffer_u8);
			buffer_write(server_buffer, buffer_u8, len);
			
			for (var i = 0; i < len; i++) {
				buffer_write(server_buffer, buffer_f16, buffer_read(buffer, buffer_f16)); //offset[0]
				buffer_write(server_buffer, buffer_f16, buffer_read(buffer, buffer_f16)); //offset[1]
				buffer_write(server_buffer, buffer_f16, buffer_read(buffer, buffer_f16)); //vel[0]
				buffer_write(server_buffer, buffer_f16, buffer_read(buffer, buffer_f16)); //vel[1]
				buffer_write(server_buffer, buffer_u16, buffer_read(buffer, buffer_u16)); //clientid
			}
			

				
			//set the type of the newly joined player
			for (var i = 0; i < ds_list_size(socket_list); i++) {
				var _sock = ds_list_find_value(socket_list, i);

				if _sock != socket {
					network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				}	
			}
			
			break;
			
		
		
		//This is for when a player disconnects whilst dead
		//	packet is recieved by "room_end" in player
		case network.player_remove_died:
			players_dead -= 1;
			break;
			
		case network.player_died:
			players_dead += 1; //death counter
			
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.player_died); //msgid
			buffer_write(server_buffer, buffer_u8, network.toclient); //destination type
			buffer_write(server_buffer, buffer_u8, socket); //socket
			
			
			//send the player who died to every client
			for (var i = 0; i < ds_list_size(socket_list); i++) {
				var _sock = ds_list_find_value(socket_list, i);

				if _sock != socket {
					network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				}	
			}
			
			
			//Need to check for a win every time a playe dies
			//	send a win check to every player if there is 1 player remaining
			//	lets hope this system isnt really fragile (like in other projects)

			if players_dead >= ds_list_size(socket_list) - 1 {
				obj_RoundAutoStart.countdown = 10;
				state = server_states.in_win_loss;
				//Tell each player to check if they have won
				buffer_seek(server_buffer, buffer_seek_start, 0);
				buffer_write(server_buffer, buffer_u8, network.win_check); //msgid
				buffer_write(server_buffer, buffer_u8, network.toclient); //destination type
				
				for (var i = 0; i < ds_list_size(socket_list); i++) {
					var _sock = ds_list_find_value(socket_list, i);

					network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				}
			
			}
			
			break;
			
		case network.respawn_death:
			//send player died because it only hides the client
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.player_died); //msgid
			buffer_write(server_buffer, buffer_u8, network.toclient); //destination type
			buffer_write(server_buffer, buffer_u8, socket); //socket
				
			//send movement to all sockets except sender
			for (var i = 0; i < ds_list_size(socket_list); i++) {
				var _sock = ds_list_find_value(socket_list, i);

				if _sock != socket {
					network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				}
			}
			break;
			
		case network.pset_health:
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.pset_health); //msgid
			buffer_write(server_buffer, buffer_u8, network.toclient); //destination type
			buffer_write(server_buffer, buffer_u8, socket); //socket
			buffer_write(server_buffer, buffer_f16, buffer_read(buffer, buffer_f16)); //val
			buffer_write(server_buffer, buffer_f16, buffer_read(buffer, buffer_f16)); //base hlth
				
			for (var i = 0; i < ds_list_size(socket_list); i++) {
				var _sock = ds_list_find_value(socket_list, i);

				if _sock != socket {
					network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				}
			}
			break;
			
		case network.game_started:
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.game_started); //msgid
			buffer_write(server_buffer, buffer_u8, network.toclient); //destination type
				
			for (var i = 0; i < ds_list_size(socket_list); i++) {
				var _sock = ds_list_find_value(socket_list, i);

				network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
			}
			break;
		
		//Needed because it reveals the player from death after its respawned
		case network.player_respawn:
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.player_respawn); //msgid
			buffer_write(server_buffer, buffer_u8, network.toclient); //destination type
			buffer_write(server_buffer, buffer_u8, socket); //socket
			
			//send movement to all sockets except sender
			for (var i = 0; i < ds_list_size(socket_list); i++) {
				var _sock = ds_list_find_value(socket_list, i);
				
				if _sock != socket {
					network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				}
			}
			break;
		
		//Rematch vote system
		//	when number of votes reach total players, restart game
		case network.rematch_vote:
			var _vote_n = buffer_read(buffer, buffer_s8); //Vote count
			rematch_votes = max(0, rematch_votes + _vote_n); //increment count
			
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.rematch_vote); //msgid
			buffer_write(server_buffer, buffer_u8, network.toclient); //destination type
			buffer_write(server_buffer, buffer_u8, rematch_votes); //vote count
			
			
			for (var i = 0; i < ds_list_size(socket_list); i++) {
				var _sock = ds_list_find_value(socket_list, i);

				network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
			}
			
			if rematch_votes >= ds_list_size(socket_list) {
				scr_GlobalReset();	
			}
			
			break;
			
		//Ready vote system
		//	when number of votes reach total players, restart game
		case network.ready_vote:
			var _vote_n = buffer_read(buffer, buffer_s8); //Vote count
			ready_votes = max(0, ready_votes + _vote_n); //increment count
			
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.ready_vote); //msgid
			buffer_write(server_buffer, buffer_u8, network.toclient); //destination type
			buffer_write(server_buffer, buffer_u8, ready_votes); //vote count
			
			
			for (var i = 0; i < ds_list_size(socket_list); i++) {
				var _sock = ds_list_find_value(socket_list, i);

				network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
			}
			
			if ready_votes >= ds_list_size(socket_list) {
				obj_Lobby.start_game()
			}
			
			break;
			
		//Sends the secondary function used by the player
		case network.use_secondary:		
		
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.use_secondary); //msgid
			buffer_write(server_buffer, buffer_u8, network.toclient); //destination type
			buffer_write(server_buffer, buffer_u8, socket); //socket
			buffer_write(server_buffer, buffer_u8, buffer_read(buffer, buffer_u8)); //secondary function id
				
			//set the type of the newly joined player
			for (var i = 0; i < ds_list_size(socket_list); i++) {
				var _sock = ds_list_find_value(socket_list, i);

				if _sock != socket {
					network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				}	
			}
			
			break;
			
		case network.event_started:		
		
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.event_started); //msgid
			buffer_write(server_buffer, buffer_u8, network.toclient); //destination type
			buffer_write(server_buffer, buffer_u8, buffer_read(buffer, buffer_u8)); //eventid
			//buffer_write(server_buffer, buffer_f16, buffer_read(buffer, buffer_f16)); //Intensity
			//buffer_write(server_buffer, buffer_f16, buffer_read(buffer, buffer_f16)); //Duration
			buffer_write(server_buffer, buffer_u8, buffer_read(buffer, buffer_u8)); //quadrant
			buffer_write(server_buffer, buffer_s16, buffer_read(buffer, buffer_s16)); //xpos
			buffer_write(server_buffer, buffer_s16, buffer_read(buffer, buffer_s16)); //ypos
			buffer_write(server_buffer, buffer_u32, buffer_read(buffer, buffer_u32)); //seed

			//set the type of the newly joined player
			for (var i = 0; i < ds_list_size(socket_list); i++) {
				var _sock = ds_list_find_value(socket_list, i);

				if _sock != socket {
					network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				}	
			}
			
			break;
		
		case network.delete_secondary:		
		
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.delete_secondary); //msgid
			buffer_write(server_buffer, buffer_u8, network.toclient); //destination type
			buffer_write(server_buffer, buffer_u8, socket); //socket
			buffer_write(server_buffer, buffer_u8, buffer_read(buffer, buffer_u8)); //secondary function id
				
			//set the type of the newly joined player
			for (var i = 0; i < ds_list_size(socket_list); i++) {
				var _sock = ds_list_find_value(socket_list, i);

				if _sock != socket {
					network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				}	
			}
			
			break;
			
		case network.create_ap:		
		
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.create_ap); //msgid
			buffer_write(server_buffer, buffer_u8, network.toclient); //destination type
			buffer_write(server_buffer, buffer_s16, buffer_read(buffer, buffer_s16)); //xpos
			buffer_write(server_buffer, buffer_s16, buffer_read(buffer, buffer_s16)); //ypos
			buffer_write(server_buffer, buffer_u8, buffer_read(buffer, buffer_u8)); //quantity
				
			//set the type of the newly joined player
			for (var i = 0; i < ds_list_size(socket_list); i++) {
				var _sock = ds_list_find_value(socket_list, i);

				if _sock != socket {
					network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				}	
			}
			
			break;
			
		case network.meteor_destroy:		
		
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.meteor_destroy); //msgid
			buffer_write(server_buffer, buffer_u8, network.toclient); //destination type
			buffer_write(server_buffer, buffer_u16, buffer_read(buffer, buffer_s16)); //id
				
			//set the type of the newly joined player
			for (var i = 0; i < ds_list_size(socket_list); i++) {
				var _sock = ds_list_find_value(socket_list, i);

				if _sock != socket {
					network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				}	
			}
			
			break;
	}
}