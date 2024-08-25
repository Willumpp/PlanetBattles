ds_queue_destroy(_pos_queue);
ds_queue_destroy(pos);

if send_server == true {
	var client_buffer = obj_Player.client_buffer;
	buffer_seek(client_buffer, buffer_seek_start, 0);
	buffer_write(client_buffer, buffer_u8, network.meteor_destroy);
	buffer_write(client_buffer, buffer_u8, network.toserver);
	buffer_write(client_buffer, buffer_u16, client_id);
	network_send_packet(obj_Player.socket, client_buffer, buffer_tell(client_buffer));
}