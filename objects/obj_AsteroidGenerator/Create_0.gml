spawn_cooldown = 0;
packet_cooldown = 0.05;
//asteroids = ds_list_create();

//Destroys all asteroids
//	resets cooldonw
function reset_asteroids() {
	spawn_cooldown = 0.5;
	
	with (obj_Asteroid) {
		destroy();	
	}
	
	if global.meteor_rate > 0 {
		//I want
		// 1/400pix^2
		//count/mapsize = 1/400
		//count = mapsize*1/400
		//var _count = room_width*room_height*(1/1061632);
		var _count = 0;
		repeat(_count) {
	
			//Instantiate asteroid at random side
			var asteroid = instance_create_layer(irandom_range(0,room_width), 
				irandom_range(0,room_height),"Asteroids", obj_Asteroid);
	
	
			//Set velocity of asteroid
			var _speed = irandom_range(1,3);
			asteroid.direction = irandom_range(0,360)
			asteroid.velocity = [0,0];
			asteroid.velocity[0] = _speed * cos(asteroid.direction*pi/180); //x-component
			asteroid.velocity[1] = _speed * sin(asteroid.direction*pi/180); //y-component
			if instance_exists(obj_Server) {
				asteroid.send_to_server();
			}
		}
	}
}

asteroid_buffer = buffer_create(4096, buffer_fixed, 1);
