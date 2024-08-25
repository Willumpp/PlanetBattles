if buffer_exists(server_buffer) {
	buffer_seek(server_buffer, buffer_seek_start, 0);
	buffer_write(server_buffer, buffer_u8, network.disconnect_client); //msgid
	buffer_write(server_buffer, buffer_u8, network.toclient); //destination type
			
	//send movement to all sockets except sender
	for (var i = 0; i < ds_list_size(socket_list); i++) {
		var _sock = ds_list_find_value(socket_list, i);
				
		network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
	}
}

network_destroy(server);