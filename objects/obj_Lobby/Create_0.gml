in_lobby = true
game_host = (instance_exists(obj_Server) == true);

function start_game() {
	scr_GlobalReset();

	in_lobby = false;
	
	//send start ping to all players
	with (obj_Player) {
		buffer_seek(client_buffer, buffer_seek_start, 0);
		buffer_write(client_buffer, buffer_u8, network.game_started);
		buffer_write(client_buffer, buffer_u8, network.toserver);
		
		network_send_packet(socket, client_buffer, buffer_tell(client_buffer));
	}
}

width = view_wport[0];
height = view_hport[0];