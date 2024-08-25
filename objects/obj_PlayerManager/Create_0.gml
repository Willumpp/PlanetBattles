function check_win() {
	if total_players == 1 and obj_Player.is_client == false {
		var p1 = instance_find(obj_Player, 0);
		var p2 = instance_find(obj_Player, 1);
		
		if p1.dead == false { //if player 1 is the winner
			display_winner(true, p1.username);
		}
		else {
			display_winner(true, p2.username);
		}
	}
}

//Set the room size (if on multiplayer)
if host == true {
	room_width = global.roomwidth;
	room_height = global.roomheight;
}

total_players = 0; //This is set by "obj_Player", it should be entirely ignored on multiplayer
//Create the player
var player1 = instance_create_layer(100, 100, "Players", obj_Player);

//username binding
var username = instance_create_layer(x, y, "Players", obj_Username); 
username.player = player1.id;

//respawn binding
var rstimer = instance_create_layer(x, y, "GUI", obj_RespawnTimer); 
rstimer.player = player1.id;
player1.respawn_timer = rstimer;

//health binding
var hlthbar = instance_create_layer(32, 64, "GUI", obj_Healthbar);
hlthbar.set_parent(player1);

//ammo binding
//var ambar = instance_create_layer(view_wport[0]-64, 64, "GUI", obj_AmmoBar);
var ambar = instance_create_layer(590, 0, "GUI", obj_AmmoBar);
ambar.set_parent(player1);
if player1.ship_type == st.red { ambar.text = "Energy: " }; //Say energy if red

//action bar (cooldown for player action ability)
var acbar = instance_create_layer(52, 143, "GUI", obj_ActionBar);
acbar.set_parent(player1);


//Connect to server if needed
if host == true { 
	//Bind mini-map
	var map = instance_create_layer(0, 0, "GUI", obj_Map);
	map.parent = player1;
	
	//Connect to host ip if hosting (if server in room)
	if instance_exists(obj_Server) { player1.connect_to_server("127.0.0.1", global.host_port); } 
	//Connect normally if not hosting (join ip in main menu)
	else { player1.connect_to_server(global.join_ip, global.join_port); } 
}
player1.set_type(global.ship_type1, global.username1, 128, 300); //Set type

//Create a second player if "singleplayer"
if twoplayers == true {
	var player2 = instance_create_layer(100, 100, "Players", obj_Player);
	
	//username binding
	var username = instance_create_layer(x, y, "Players", obj_Username); 
	username.player = player2.id;
	
	//health binding
	var hlthbar2 = instance_create_layer(view_wport[0] - 320 - 32 - 176, view_hport[0] - 64, "GUI", obj_Healthbar);
	hlthbar2.set_parent(player2);
	
	//respawn binding
	var rstimer = instance_create_layer(x, y, "GUI", obj_RespawnTimer); 
	rstimer.player = player2.id;
	player2.respawn_timer = rstimer;
	

	//ammo binding
	var ambar2 = instance_create_layer(0, view_hport[0]-32, "GUI", obj_AmmoBar);
	ambar2.set_parent(player2);
	ambar2.player1 = false;
	ambar2.colour = c_lime;
	if player2.ship_type == st.red { ambar2.text = "Energy: " }; //Say energy if red
	
	with (player2) {
		set_type(global.ship_type2, global.username2, room_width-100, room_height-100);	
	}
}

//Reset's player positions
//	reset "winner" and "loser" message visiblity
//	type - (essentially health)
function reset_players() {
	if host == true {
		room_width = global.roomwidth;
		room_height = global.roomheight;
		
		obj_Player.ship_type = global.ship_type1;
		with obj_Player {
			//This sends the type information of the player
			buffer_seek(client_buffer, buffer_seek_start, 0);
			buffer_write(client_buffer, buffer_u8, network.set_player);
			buffer_write(client_buffer, buffer_u8, network.toserver);
			buffer_write(client_buffer, buffer_u8, global.ship_type1);
			buffer_write(client_buffer, buffer_string, global.username1);
			buffer_write(client_buffer, buffer_u8, pstates.alive);
	
			network_send_packet(socket, client_buffer, buffer_tell(client_buffer));	
		}
	}
	
	layer_set_visible("WinLoss", false);
	
	//reset players
	with (obj_Player) {	
		scr_PlayerReset();
		scr_PlayerChildrenCleanup()
	}
	
	//Reset ammo packs
	with obj_AmmoPack { 
		instance_destroy();	
	}
	
}

//Called when a winner has been decided
//	called by the player manager
function display_winner(is_winner, name) {
	layer_set_visible("WinLoss", true);
	obj_Winner.visible = true;
	obj_Winner.winner_name = name;
}

