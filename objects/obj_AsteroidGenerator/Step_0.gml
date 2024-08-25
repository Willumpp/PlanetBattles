
if spawn_cooldown < 0  {
	spawn_cooldown = 0.5; //Spawn every 0.5 seconds
	
	//Array of possible positions to use
	var positions = [[irandom_range(0,room_width), -80], [-50, irandom_range(0,room_height)],
					 [irandom_range(0,room_width), room_height+20], [room_width+80, irandom_range(0,room_height)]];
	var choice = irandom_range(0,3); //Random possible position
	
	//Instantiate asteroid at random side
	var asteroid = instance_create_layer(positions[choice][0], positions[choice][1],"Asteroids", obj_Asteroid);
	
	//Choose direction of travel
	switch choice {
		case 0: //Top : 0 -> 180
			asteroid.direction = irandom_range(20, 160);
			break;
		case 1: //Left : -90 -> 90
			asteroid.direction = irandom_range(-70, 70);
			break;
		case 2: //Bottom : -180 -> 0
			asteroid.direction = irandom_range(-160, -20);
			break;
		case 3: //Right : 90 -> 270
			asteroid.direction = irandom_range(70, 250);
			break;
	}
	
	//Set velocity of asteroid
	var _speed = irandom_range(1,3);
	asteroid.velocity = [0,0];
	asteroid.velocity[0] = _speed * cos(asteroid.direction*pi/180); //x-component
	asteroid.velocity[1] = _speed * sin(asteroid.direction*pi/180); //y-component
	if instance_exists(obj_Server) {
		asteroid.send_to_server();
	}
}
else {
	spawn_cooldown -= global.dt * global.meteor_rate;
}

//packet_cooldown -= global.dt;
packet_cooldown = -1;
if instance_exists(obj_Server) and instance_number(obj_Asteroid) > 1 and packet_cooldown < 0 {
	var client_buffer = asteroid_buffer;
	buffer_seek(client_buffer, buffer_seek_start, 0);
	buffer_write(client_buffer, buffer_u8, network.meteor_move);
	buffer_write(client_buffer, buffer_u8, network.toserver);
	//packet_cooldown = (1/60);
	var render_distance = 2000;


	var count = 0;
	with obj_Asteroid {
		//if distance_to_object(instance_nearest(x, y, obj_Player)) < render_distance or 
		if perform_calcs == true or 
			distance_to_object(instance_nearest(x, y, obj_Client)) < render_distance {
			count += 1;
		}
	}
	
	buffer_write(client_buffer, buffer_u8, count);
	
	with obj_Asteroid {
		if perform_calcs == true or 
			distance_to_object(instance_nearest(x, y, obj_Client)) < render_distance and instance_exists(id) {
			buffer_write(client_buffer, buffer_f16, offset[0]);
			buffer_write(client_buffer, buffer_f16, offset[1]);
			buffer_write(client_buffer, buffer_f16, velocity[0]);
			buffer_write(client_buffer, buffer_f16, velocity[1]);
			buffer_write(client_buffer, buffer_u16, client_id);
		}
	}
	if count > 0 {
		network_send_packet(obj_Player.socket, client_buffer, buffer_tell(client_buffer));
	}
	
}