asset_clear_tags(id, asset_object);
scr_PlayerChildrenCleanup();
scr_EventCleanup();
part_type_destroy(parTypeShoot);
part_type_destroy(parTypeTrail);
part_type_destroy(parTypeDeath);
if is_client == true {
	//This is for when a player disconnects whilst dead
	//	packet is recieved by "room_end" in player
	if dead == true and instance_exists(obj_Server) and buffer_exists(client_buffer) {
		buffer_seek(client_buffer, buffer_seek_start, 0);
		buffer_write(client_buffer, buffer_u8, network.player_remove_died);
		buffer_write(client_buffer, buffer_u8, network.toserver);

		network_send_packet(socket, client_buffer, buffer_tell(client_buffer));
	}
	ds_map_destroy(socket_map); 
	buffer_delete(client_buffer);
	network_destroy(socket);
}
