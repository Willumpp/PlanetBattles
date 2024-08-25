cam = view_camera[0] //Used for frustum culling calculations
perform_calcs = true;
draw_red = false;

send_server = false;
client_id = 0;
total_sides = 10; //Number of sides the asteroid has
side_scale = irandom_range(20,30)*global.meteor_scale; //Scale of the sides
image_xscale = side_scale / 25
image_yscale = image_xscale

var _return = scr_AsteroidPositions(total_sides, side_scale);
_pos_queue = ds_queue_create();
pos = _return[0]; //Position queue
centre = _return[1]; //Centre of all vertices in asteroid
delete_border = 100; //How far from the edge until deletion

offset = [0,0]; //Offset from position of creation
velocity = [0,0]; //Direction of movement
angle = 0; //Rotation of the asteriod

//parTypePoint = part_type_create();
//parPoint(parTypePoint);

function destroy() {
	
	//part_type_destroy(parTypePoint);
	instance_destroy(id);
}

function send_to_server() {
	send_server = true;
	client_id = id;
	var pos_queue = ds_queue_create();
	ds_queue_copy(pos_queue, pos);
	
	var client_buffer = obj_Player.client_buffer;
	buffer_seek(client_buffer, buffer_seek_start, 0);
	buffer_write(client_buffer, buffer_u8, network.meteor_create);
	buffer_write(client_buffer, buffer_u8, network.toserver);
	buffer_write(client_buffer, buffer_f16, centre[0]);
	buffer_write(client_buffer, buffer_f16, centre[1]);
	buffer_write(client_buffer, buffer_s16, x);
	buffer_write(client_buffer, buffer_s16, y);
	buffer_write(client_buffer, buffer_f16, image_xscale);
	buffer_write(client_buffer, buffer_f16, velocity[0]);
	buffer_write(client_buffer, buffer_f16, velocity[1]);
	buffer_write(client_buffer, buffer_u16, client_id);
	
	//This is for copying and writing each pos to the buffer
	//	cannot send a queue across network
	buffer_write(client_buffer, buffer_u8, ds_queue_size(pos_queue));
	for (var i = 0; i < ds_queue_size(pos); i++) {
		var _pos = ds_queue_dequeue(pos_queue)
		buffer_write(client_buffer, buffer_f16, _pos[0]);
		buffer_write(client_buffer, buffer_f16, _pos[1]);
	}

	//NOTE; "network_send_packet" does not send the packet directly to the socket
	//		it sends the data to the server with the socket id
	network_send_packet(obj_Player.socket, client_buffer, buffer_tell(client_buffer));
	ds_queue_destroy(pos_queue);
}

function coll_info() {
	if send_server == true {
		
		var client_buffer = obj_AsteroidGenerator.asteroid_buffer;
		buffer_seek(client_buffer, buffer_seek_start, 0);
		buffer_write(client_buffer, buffer_u8, network.meteor_move);
		buffer_write(client_buffer, buffer_u8, network.toserver);	
		buffer_write(client_buffer, buffer_u8, 1);
		buffer_write(client_buffer, buffer_f16, offset[0]);
		buffer_write(client_buffer, buffer_f16, offset[1]);
		buffer_write(client_buffer, buffer_f16, velocity[0]);
		buffer_write(client_buffer, buffer_f16, velocity[1]);
		buffer_write(client_buffer, buffer_u16, client_id);
		network_send_packet(obj_Player.socket, client_buffer, buffer_tell(client_buffer));
	}
}