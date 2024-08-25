//function scr_StartEvent(eventid, intensity, duration, evseed, quadrant, xpos, ypos){
function scr_StartEvent(eventid, evseed, quadrant, xpos, ypos){
	switch eventid {
		case event.ping:
			show_debug_message("pong");
			break;
		case event.test:
			scr_EventCreate(obj_EventTest, 1, 1, evseed, quadrant, xpos, ypos);
			break;
		case event.grb:
			scr_EventCreate(obj_EvGRB, 40, 3, evseed, quadrant, xpos, ypos);
			break;
		case event.wormhole:
			scr_EventCreate(obj_EvWormhole, 1, -1, evseed, quadrant, xpos, ypos);
			break;
		case event.blackhole:
			scr_EventCreate(obj_EvBlackhole, 4, 45, evseed, quadrant, xpos, ypos);
			break;
		default:
			show_debug_message("event unknown");
			break;
	}
	
	if instance_exists(obj_Server) {
		with obj_Player {
			buffer_seek(client_buffer, buffer_seek_start, 0);
			buffer_write(client_buffer, buffer_u8, network.event_started);
			buffer_write(client_buffer, buffer_u8, network.toserver);
			buffer_write(client_buffer, buffer_u8, eventid);
			//buffer_write(client_buffer, buffer_f16, intensity);
			//buffer_write(client_buffer, buffer_f16, duration);
			buffer_write(client_buffer, buffer_u8, quadrant);
			buffer_write(client_buffer, buffer_s16, xpos);
			buffer_write(client_buffer, buffer_s16, ypos);
			buffer_write(client_buffer, buffer_u32, evseed);

			network_send_packet(socket, client_buffer, buffer_tell(client_buffer));
		}
	}
}