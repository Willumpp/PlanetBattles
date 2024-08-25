type_event = ds_map_find_value(async_load, "type");

switch(type_event) {
	//When a player is connecting,
	//	create a "obj_Slave" for every player using "player joined"
	//	create a "obj_Slave" for every existing player so the client can see
	case network_type_connect:
		var joined_socket = ds_map_find_value(async_load, "socket");

		//if a game is already happening, this "kills" the client
		//	this is so the player can spectate when joined
		if state == server_states.in_game {
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.game_connect);
			buffer_write(server_buffer, buffer_u8, network.toclient);

			network_send_packet(joined_socket, server_buffer, buffer_tell(server_buffer));
		}
		//Performs similar in the winloss menu so the game does not break
		else if state == server_states.in_win_loss {
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.winloss_connect);
			buffer_write(server_buffer, buffer_u8, network.toclient);

			network_send_packet(joined_socket, server_buffer, buffer_tell(server_buffer));
		}
		
		//Create a "obj_Client" as the newly joined player
		buffer_seek(server_buffer, buffer_seek_start, 0);
		buffer_write(server_buffer, buffer_u8, network.player_joined);
		buffer_write(server_buffer, buffer_u8, network.toclient);
		buffer_write(server_buffer, buffer_u8, joined_socket);
	
		
		for (var i = 0; i < ds_list_size(socket_list); i++) {
			//The request creates a "obj_Slave" at the client
			network_send_packet(ds_list_find_value(socket_list, i), server_buffer, buffer_tell(server_buffer));
		}
		
		
		//Create a "obj_Client" as every other player
		for (var i = 0; i < ds_list_size(socket_list); i++) {
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.player_joined);
			buffer_write(server_buffer, buffer_u8, network.toclient);
			buffer_write(server_buffer, buffer_u8, ds_list_find_value(socket_list, i));

			network_send_packet(joined_socket, server_buffer, buffer_tell(server_buffer));
		}

		ds_list_add(socket_list, joined_socket);
		
		break;
		
	case network_type_disconnect:
		var left_socket = ds_map_find_value(async_load, "socket");
		var _socket_pos = ds_list_find_index(socket_list, left_socket);
		
		//If the player failed to join and was forced to disconnect:
		if _socket_pos == -1 {
			break;	
		}
		
		//Resets the votes for all players
		with (obj_RematchM) {
			vote(-votes);
		}
		
		ds_list_delete(socket_list, _socket_pos);
		
				
		//Delete the "obj_Client" for every other player
		buffer_seek(server_buffer, buffer_seek_start, 0);
		buffer_write(server_buffer, buffer_u8, network.player_disconnect);
		buffer_write(server_buffer, buffer_u8, network.toclient);
		buffer_write(server_buffer, buffer_u8, left_socket);
		for (var i = 0; i < ds_list_size(socket_list); i++) {
			//The request creates a "obj_Slave" at the client
			network_send_packet(ds_list_find_value(socket_list, i), server_buffer, buffer_tell(server_buffer));
		}
	
		
		break;
	
	//Any data being sent to any socket goes through the server
	case network_type_data:
		var buffer = ds_map_find_value(async_load, "buffer");
		var socket = ds_map_find_value(async_load, "id");
		buffer_seek(buffer, buffer_seek_start, 0); //Goes to the start of the buffer, first position in data
		
		var msgid = buffer_read(buffer, buffer_u8);
		var destination = buffer_read(buffer, buffer_u8);
		
		if (destination == network.toserver) {
			scr_ServerPacket(buffer, msgid, socket);
		}
		break;
}