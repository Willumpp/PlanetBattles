type_event = ds_map_find_value(async_load, "type");


switch(type_event) {
	case network_type_data:
		buffer = ds_map_find_value(async_load, "buffer");
		recieved_socket = ds_map_find_value(async_load, "id");

		buffer_seek(buffer, buffer_seek_start, 0); //Goes to the start of the buffer, first position in data
		
		var msgid = buffer_read(buffer, buffer_u8);
		var destination = buffer_read(buffer, buffer_u8);
		
		if (destination == network.toclient) {
			scr_ClientPacket(buffer, msgid);
		}
		break;
}