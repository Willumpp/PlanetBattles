
//Generate new ammo pack every x seconds randomly on the map
//	also sends the information to the clients if on multiplayer
if spawn_cooldown < 0 and instance_number(obj_AmmoPack) < global.ammo_count {
	spawn_cooldown = 10;
	var xpos = irandom_range(0, room_width);
	var ypos = irandom_range(0, room_height);
	
	var quant = irandom_range(5,10);
	
	scr_GenerateAmmoPack(xpos, ypos, quant);
	
	//Send information if on the server
	if instance_exists(obj_Server) {
		with obj_Player {
			buffer_seek(client_buffer, buffer_seek_start, 0);
			buffer_write(client_buffer, buffer_u8, network.create_ap);
			buffer_write(client_buffer, buffer_u8, network.toserver);
			buffer_write(client_buffer, buffer_s16, xpos);
			buffer_write(client_buffer, buffer_s16, ypos);
			buffer_write(client_buffer, buffer_u8, quant); //Quantity
		
		
			network_send_packet(socket, client_buffer, buffer_tell(client_buffer));
		}
	}
}
if spawn_cooldown >= 0 {
	spawn_cooldown -= global.dt * global.ammo_rate
}