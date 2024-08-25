function scr_ClientPacket(buffer, msgid) {
	switch(msgid) {
		case network.disconnect_client:
			disconnect_from_server();
			show_message("Disconnected - likely has game already started or host left");
			room_goto(MainMenu);
			break;
		
		//socket
		//	create slave with new joined socket and coordinates
		//	send the create data of the player to the newly joined client
		case network.player_joined:
			var _socket = buffer_read(buffer, buffer_u8);
			var _obj = instance_create_layer(100, 100, "Players", obj_Client);
			ds_map_add(socket_map, _socket, _obj.id);
			
			var username = instance_create_layer(x, y, "Players", obj_Username); 
			username.player = _obj.id;
			
			//Send colour information to everyone - you could consider this horribly bad, im not sure
			//	it is only called when a new player joins anyway tbh
			buffer_seek(client_buffer, buffer_seek_start, 0);
			buffer_write(client_buffer, buffer_u8, network.set_player);
			buffer_write(client_buffer, buffer_u8, network.toserver);
			buffer_write(client_buffer, buffer_u8, global.ship_type1);
			buffer_write(client_buffer, buffer_string, global.username1);
			buffer_write(client_buffer, buffer_u8, state);
	
			network_send_packet(socket, client_buffer, buffer_tell(client_buffer));
			break;
		
		//destroys client instance
		//	destroys username of the client
		case network.player_disconnect:
			var _socket = buffer_read(buffer, buffer_u8);

			
			with (ds_map_find_value(socket_map, _socket)) {
				scr_PlayerChildrenCleanup();
			}
			
			instance_destroy(ds_map_find_value(socket_map, _socket)); //destroy the client
			ds_map_delete(socket_map, _socket);
			
			//Resets client-side when player disconnects
			obj_RematchM.reset_votes();
			break;
		
		//moved socket, x, y
		case network.player_move:
			var _socket = buffer_read(buffer, buffer_u8); //socket
			var _x = buffer_read(buffer, buffer_s16); //x
			var _y = buffer_read(buffer, buffer_s16); //y
			var _velx = buffer_read(buffer, buffer_s16); //x
			var _vely = buffer_read(buffer, buffer_s16); //y
			var _angle = buffer_read(buffer, buffer_s16); //image_angle
			
			var _slave = ds_map_find_value(socket_map, _socket);
			_slave.x = _x;
			_slave.y = _y;
			_slave.velocity[0] = _velx;
			_slave.velocity[1] = _vely;
			_slave.image_angle = _angle;

			break;
		
		//recieved every time a player shoots
		//	creates a bullet at the corresponding player
		case network.fire_bullet:
			var _socket = buffer_read(buffer, buffer_u8); //socket
			var _spd = buffer_read(buffer, buffer_u8); //spd
			var _dmg = buffer_read(buffer, buffer_f16); //dmg
			var _angle = buffer_read(buffer, buffer_s16); //angle
			var _xscale = buffer_read(buffer, buffer_f16); //xscale
			var _yscale = buffer_read(buffer, buffer_f16); //yscale
			var _sound = buffer_read(buffer, buffer_u8); //bullet sound
			//var _spr = buffer_read(buffer, buffer_u8); //sprite
			
			var _slave = ds_map_find_value(socket_map, _socket);
			_slave.bullet_func(_spd, _dmg, _angle, _xscale, _yscale, _sound);
			break;
		
		
		//Creates an asteroid like the asteroid generator would
		//	recieved after the host's asteroid generator creates an asteroid
		case network.create_asteroid:
			var _x = buffer_read(buffer, buffer_s16);
			var _y = buffer_read(buffer, buffer_s16);
			var _spd = buffer_read(buffer, buffer_u8);
			var _dir = buffer_read(buffer, buffer_s16);
			var _scale = buffer_read(buffer, buffer_u8);
			
			if instance_exists(obj_AsteroidGenerator) == false {
				//Create an asteroid
				var asteroid = instance_create_layer(_x, _y, "Asteroids", obj_Asteroid);
			
				//Rotate
				asteroid.direction = _dir;
			
				//Generate velocity from direction
				asteroid.velocity[0] = _spd * cos(asteroid.direction*pi/180); //x-component
				asteroid.velocity[1] = _spd * sin(asteroid.direction*pi/180); //y-component
			
				//Scale the collision box
				asteroid.image_xscale = _scale / 25
				asteroid.image_yscale = _scale / 25
			
				//Generate new vertex positions based off the new scale and location
				with (asteroid) {
					var _return = scr_AsteroidPositions(10, _scale);
					pos = _return[0]; //Position queue
					centre = _return[1]; //Centre of all vertices in asteroid
				}
			}
			
			break;
			
		case network.create_ap:
			var _x = buffer_read(buffer, buffer_s16);
			var _y = buffer_read(buffer, buffer_s16);
			var _quantity = buffer_read(buffer, buffer_u8);
			
			scr_GenerateAmmoPack(_x, _y, _quantity);
			
			break;
		
		//Sets variable information of the player after it's connection
		//	every time a player connects, this is recieved by everyone
		//	everyone also sends their information out
		case network.set_player:
			var _socket = buffer_read(buffer, buffer_u8); //socket
			var _type = buffer_read(buffer, buffer_u8); //type
			var _username = buffer_read(buffer, buffer_string); //username
			var _state = buffer_read(buffer, buffer_u8); //server state
			
			var _inst = ds_map_find_value(socket_map, _socket);
			//_inst.set_type(_type, _username, _inst.start_x, _inst.start_y);
			
			var username = instance_create_layer(_inst.x, _inst.y, "Players", obj_Username);
			username.parent = _inst.id;
			
			_inst.state = _state;
			
			switch _state {
				case pstates.dead:
					with _inst { death_scripts(); }
					break;
					
				case pstates.alive:
					_inst.set_type(_type, _username, _inst.start_x, _inst.start_y);
					break;
			}
			
			break;
		
		//When a player has died, remove the corresponding slave
		case network.player_died:
			var _socket = buffer_read(buffer, buffer_u8);
			var _slave = ds_map_find_value(socket_map, _socket);
			
			if _slave != undefined and instance_exists(_slave) {
				with (_slave) {
					//scr_Death();
					dead = true;
					obj_PlayerManager.total_players -= 1;
					
					death_scripts()
				}
			}
			break;
		
		//When a player has respawned
		case network.player_respawn:
			var _socket = buffer_read(buffer, buffer_u8);
			var _slave = ds_map_find_value(socket_map, _socket);
		
			with (_slave) {
				//obj_AudioController.sfx_play(sndShipExplosion, x, y);
				scr_PlayerReset();
			}
			break;
		
		//This is recieved when only 1 player remains (the winner)
		case network.win_check:
			obj_RoundAutoStart.countdown = 10;
			
			//check if you are the winner
			if obj_Player.dead == false {
				obj_PlayerManager.display_winner(true, global.username1);
				
				scr_IncreaseStat("Games Won", 1);
				obj_Player.win_count += 1;
			}
			else { //find the other winner (a client)
				for (var i = 0; i < instance_number(obj_Client); i++) { 
					var client = instance_find(obj_Client, i);
					
					//Winner is found
					if client.dead == false {
						//display win message
						obj_PlayerManager.display_winner(true, client.username);
						client.win_count += 1;
						break;
					}
				}
				
				obj_PlayerManager.display_winner(true, "nobody");
			}
			

			break;
		
		//Does a player manager reset
		//	does a asteroid generator reset
		//	additionally resets all the clients
		case network.player_reset:
			//set start position of the player
			obj_Player.start_x = buffer_read(buffer, buffer_s16);
			obj_Player.start_y = buffer_read(buffer, buffer_s16);
			
			obj_RematchM.reset_votes();
			if instance_exists(obj_Ready) {
				obj_Ready.reset_votes();
			}
			obj_PlayerManager.reset_players();
			
			//Reset every client, excluding the player
			var clients = ds_map_values_to_array(socket_map);
			for (var i = 0; i < ds_map_size(socket_map); i++) {
				if clients[i] != obj_Player {
					with (clients[i]) {
						scr_PlayerReset();	
					}
				}
			}
			
			//destroy all asteroids if the asteroid generate doesnt exist
			if instance_exists(obj_AsteroidGenerator) == false {
				with (obj_Asteroid) {
					destroy();	
				}
			}
			
			if instance_exists(obj_EventController) == false {
				scr_EventCleanup();
			}
		
			break;
			
		case network.game_started:
			obj_Lobby.in_lobby = false;
			
			if instance_exists(obj_Ready) {
				with obj_Ready { instance_destroy() }	
			}

			break;
			
		case network.winloss_connect:
			obj_Lobby.in_lobby = false;
			
			if instance_exists(obj_Ready) {
				with obj_Ready { instance_destroy() }	
			}
			dead = true;
			scr_Death();

			break;
			
		case network.game_connect:
			obj_Lobby.in_lobby = false;
			if instance_exists(obj_Ready) {
				with obj_Ready { instance_destroy() }	
			}
			
			dead = false;
			scr_Death();
			layer_set_visible("WinLoss", false);

			break;
		
		//Recieves the total rematch votes
		case network.rematch_vote:
			var _vote_n = buffer_read(buffer, buffer_u8); //Vote count
			obj_RematchM.votes = _vote_n;
			
			break;
			
		//Recieves the total ready votes
		case network.ready_vote:
			var _vote_n = buffer_read(buffer, buffer_u8); //Vote count
			obj_Ready.votes = _vote_n;
			
			break;
			
		//use the secondary function as the client
		case network.use_secondary:
			var _socket = buffer_read(buffer, buffer_u8); //socket
			var _sec = buffer_read(buffer, buffer_u8); //secondary function
			
			var _func = scr_GetSecondary(_sec);
			
			var _slave = ds_map_find_value(socket_map, _socket);
			with _slave {
				_func(obj_Player);
			}
			break;
			
		case network.event_started:
			var _id = buffer_read(buffer, buffer_u8);
			//var _intensity = buffer_read(buffer, buffer_f16);
			//var _duration = buffer_read(buffer, buffer_f16);
			var _quadrant = buffer_read(buffer, buffer_u8);
			var _xpos = buffer_read(buffer, buffer_s16);
			var _ypos = buffer_read(buffer, buffer_s16);
			var _seed = buffer_read(buffer, buffer_u32);
			
			//scr_StartEvent(_id, _intensity, _duration, _seed, _quadrant, _xpos, _ypos);
			scr_StartEvent(_id, _seed, _quadrant, _xpos, _ypos);

			break;
			
		//Delete the client's secondary ability
		case network.delete_secondary:
			var _socket = buffer_read(buffer, buffer_u8); //socket
			var _sec = buffer_read(buffer, buffer_u8); //secondary function
			
			var _obj = scr_GetSecondaryObject(_sec);
			var _slave = ds_map_find_value(socket_map, _socket);
			with _obj {
				if player == _slave {
					instance_destroy();	
				}
			}
			break;
			
		case network.pset_health:
			var _socket = buffer_read(buffer, buffer_u8); //socket
			var _val = buffer_read(buffer, buffer_f16); 
			var _base = buffer_read(buffer, buffer_f16);
			
			var _slave = ds_map_find_value(socket_map, _socket);
			_slave.hlth = _val;
			_slave.base_health = _base;
			break;
			
		case network.apply_options:
			var _ocount = buffer_read(buffer, buffer_u8);
			
			for (var i = 0; i < _ocount; i++) {
				var _string = buffer_read(buffer, buffer_string);
				var _selected = buffer_read(buffer, buffer_u8);
				
				scr_ApplyOption(_string, _selected);
			}
			
			//Remember to re-apply globals onto the player if they apply during create
			lifes = global.lifes;
			
			break;
			
		//Creates a meteor at a position
		//	this is so every meteor looks the same and has the same center
		//	the "pos" queue is changed, also calculates new centre
		case network.meteor_create:
			var _cent0 = buffer_read(buffer, buffer_f16);
			var _cent1 = buffer_read(buffer, buffer_f16);
			var _x = buffer_read(buffer, buffer_s16);
			var _y = buffer_read(buffer, buffer_s16);
			var _xscale = buffer_read(buffer, buffer_f16);
			var _velx = buffer_read(buffer, buffer_f16);
			var _vely = buffer_read(buffer, buffer_f16);
			var _clientid = buffer_read(buffer, buffer_u16);
			var _len = buffer_read(buffer, buffer_u8);
			var _posqueue = ds_queue_create();
			
			var _pos_totalx = 0;
			var _pos_totaly = 0;
			
			for (var i = 0; i < _len; i++) {
				var _posx = buffer_read(buffer, buffer_f16);
				var _posy = buffer_read(buffer, buffer_f16);
				_pos_totalx += _posx;
				_pos_totaly += _posy;
				
				ds_queue_enqueue(_posqueue, [_posx, _posy]);	
			}
			
			var _inst = instance_create_layer(x, y, "Asteroids", obj_Asteroid);
			with _inst {
				x = _x;
				y = _y;
				client_id = _clientid;
				centre[0] = _pos_totalx/_len
				centre[1] = _pos_totaly/_len;
				velocity[0] = _velx;
				velocity[1] = _vely;
				image_xscale = _xscale;
				image_yscale = _xscale;
				ds_queue_clear(pos);
				ds_queue_copy(pos, _posqueue);
			}
			ds_queue_destroy(_posqueue)

			break;
		
		//Moves the meteor to an x and y position (also changes velocity)
		/*
		case network.meteor_move:
			var _offx = buffer_read(buffer, buffer_s16);
			var _offy = buffer_read(buffer, buffer_s16);
			var _velx = buffer_read(buffer, buffer_s16);
			var _vely = buffer_read(buffer, buffer_s16);
			var _id = buffer_read(buffer, buffer_u16);
			
			with obj_Asteroid {
				if client_id == _id {
					offset[0] = _offx;
					offset[1] = _offy;
					velocity[0] = _velx;
					velocity[1] = _vely;
				}
			}
			break;
			*/
			
		case network.meteor_move:
			var _len = buffer_read(buffer, buffer_u8);
			
			for (var i = 0; i < _len; i++) {
				var _offx = buffer_read(buffer, buffer_f16);
				var _offy = buffer_read(buffer, buffer_f16);
				var _velx = buffer_read(buffer, buffer_f16);
				var _vely = buffer_read(buffer, buffer_f16);
				var _id = buffer_read(buffer, buffer_u16);
			
				with obj_Asteroid {
					if client_id == _id {
						offset[0] = _offx;
						offset[1] = _offy;
						velocity[0] = _velx;
						velocity[1] = _vely;
					}
				}
			}
			break;
			
		case network.meteor_destroy:
			var _id = buffer_read(buffer, buffer_u16);
			
			with obj_Asteroid {
				if client_id == _id {
					instance_destroy();
				}
			}
			break;
		
	}
}