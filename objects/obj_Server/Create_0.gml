port = global.host_port;
max_players = 4;

enum network {
	toserver,
	toclient,
	disconnect_client,
	winloss_connect,
	game_connect,
	set_player,
	player_move,
	player_joined,
	player_disconnect,
	fire_bullet,
	create_asteroid,
	create_ap,
	player_died,
	player_remove_died,
	respawn_death,
	win_check,
	player_reset,
	game_started,
	rematch_vote,
	ready_vote,
	use_secondary,
	delete_secondary,
	event_started,
	apply_options,
	player_respawn,
	meteor_create,
	meteor_move,
	meteor_destroy,
	pset_health,
}

enum server_states {
	ignore_request,
	in_lobby,
	in_game,
	in_win_loss,
}
rematch_votes = 0;
ready_votes = 0;
server_buffer = buffer_create(1024, buffer_fixed, 1);
//in_game = false; //determines if a player can join or not, set by "reset" and "player_died" "lobby"
state = server_states.in_lobby;


socket_list = ds_list_create(); //List of all sockets connected
server = network_create_server(network_socket_tcp, port, max_players);

//anyone who's player object is alive wins (if not, loses)
players_dead = 0; //when this counter reches to (total players)-1, a win detection is sent out

//reset death count
//	send reset message to all clients
function reset_clients() {
	players_dead = 0;
	rematch_votes = 0;
	in_game = false;
	
	//send information to all sockets(clients/obj_Players connected)
	for (var i = 0; i < ds_list_size(socket_list); i++) {
		var startx = 0;
		var starty = 0;
		
		//Distribute players accross room by creating in each corner
		switch(i+1) {
			case 1:
				startx = 128
				starty = 300;
				break;
					
			case 2:
				startx = room_width - 100;
				starty = room_height - 100;
				break;
					
			case 3:
				startx = room_width - 100;
				starty = 100;
				break;
					
			case 4:
				startx = 100;
				starty = room_height - 100;
				break;
		}
		
		buffer_seek(server_buffer, buffer_seek_start, 0);
		buffer_write(server_buffer, buffer_u8, network.player_reset);
		buffer_write(server_buffer, buffer_u8, network.toclient);
		buffer_write(server_buffer, buffer_s16, startx); //start x position
		buffer_write(server_buffer, buffer_s16, starty); //start y position
				
		network_send_packet(ds_list_find_value(socket_list, i), server_buffer, buffer_tell(server_buffer));
	}
}