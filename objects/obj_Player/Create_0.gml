shield_active = false; 
shield_health = 0;
hlth = 0;

//This tag system is appalling
//	why does gamemaker tags act so differenty with the player?
//	and why do tags for assets retain outide of a room
//	and why do tags now applied on the asset browser count towards the found tags in the game
//		and why does this not apply to bullets????
//This is currently used for finding the nearest player with the secondary attacks
asset_add_tags(id, "player", asset_object);
enum st {
	red,
	green,
	blue,
}

enum secondary {
	null,
	shield,
	shockwave, 
	lifedrain,
	homingbullet,
	homingbarrage,
	laser,
	bouncearmada,
	createshield,
	destroyshield,
	astershield,
	missile,
	energyspray,
}

enum weapons {
	rifle,
	revolver,
	minigun,
}


//This is for networking when creating clients with a state
enum pstates {
	dead,
	alive,
}

//Changes variables for ship types
function set_type(type, name, startx, starty) {
	ship_type = type;
	username = name;
	
	//1: red, 2: green, 3: blue
	switch type {
		case st.red:
			acc = red_speed;
			max_speed = 8;
			base_damage = red_damage;
			hlth = red_health;
			action_function = secondary.missile;
			secondary_func = secondary.energyspray
			sprite_index = spr_Player1;
			break;
			
		case st.green:
			acc = green_speed;
			max_speed = 6;
			base_damage = green_damage;
			hlth = green_health;
			action_function = secondary.astershield
			secondary_func = secondary.homingbarrage
			sprite_index = spr_Player2;
			break;	
			
		case st.blue:
			acc = blue_speed;
			max_speed = 5;
			base_damage = blue_damage;
			hlth = blue_health;
			action_function = secondary.shield
			secondary_func = secondary.laser
			sprite_index = spr_Player3;
			break;	
		
	}
	
	start_x = startx;
	start_y = starty;
	

	
	hlth *= global.health_multiplier; //Optional multiplier
	base_health = hlth;
	set_health(hlth);
}



function set_health(val) {
	//Apply damage multiplayer when losing health
	if val < hlth {
		val = hlth- (hlth-val)*global.damage_multiplier
		scr_IncreaseStat("Damage Taken", (hlth-val)*global.damage_multiplier);
	}
	
	//If the shield is present, take shield health away instead
	//	usually active with blue
	if shield_active == true {
		shield_health = min(shield_health - (hlth - val), shield_health); //min so the shield can only go down
	}
	else {
		hlth = min(val, base_health);
	}
	
	
	//update health bar if health bar connected
	if hlth_bar != undefined { 
		hlth_bar.update_bar(); 
		
		
		if shield_active == true {
			hlth_bar.update_shield();
		}
		
	}
	
	//Send damage to server to update clients
	if is_client == true {
		buffer_seek(client_buffer, buffer_seek_start, 0);
		buffer_write(client_buffer, buffer_u8, network.pset_health);
		buffer_write(client_buffer, buffer_u8, network.toserver);
		buffer_write(client_buffer, buffer_f16, val);
		buffer_write(client_buffer, buffer_f16, base_health);
		network_send_packet(socket, client_buffer, buffer_tell(client_buffer));	
	}
	
	//Destroy shield if gone
	
	if shield_health <= 0 and shield_active == true {
		shield_active = false;
		action_active = false;
		scr_DestroyShield()
		
		if is_client == true {
			buffer_seek(client_buffer, buffer_seek_start, 0);
			buffer_write(client_buffer, buffer_u8, network.use_secondary);
			buffer_write(client_buffer, buffer_u8, network.toserver);
			buffer_write(client_buffer, buffer_u8, secondary.destroyshield);
		
			network_send_packet(socket, client_buffer, buffer_tell(client_buffer));	
		}
	}
	
	
	
	//when a death occurs
	//	update player manager
	//	(if in multiplayer) send that a player died to every client
	//	check who the winner is
	//	display a winner
	if hlth <= 0 and lifes > 1 and dead == false { 
		scr_RespawnDeath();
		
		if is_client == true and respawn_timer != undefined { 
			respawn_timer.respawn(3);
		}
	}
	else if hlth <= 0 and dead == false{
		sprite_index = -1;
		scr_Death();
	}
}

function set_ammo(val) {
	//Unlimited ammo condition
	if global.unlimited_ammo == false {
		//Clamp ammo
		ammo = val;
		ammo = clamp(ammo, 0, max_ammo);
	
		if ammo_bar != undefined {
			ammo_bar.update_bar();
		}
	}
}

//Movement in singleplayer
//	AD to turn WS to move forward/backward
function singleplayer_movement() {
	
	move_strengthh = keyboard_check(k_left) - keyboard_check(k_right);
	move_strengthv = keyboard_check(k_up) - keyboard_check(k_down);

	
	image_angle += move_strengthh * turn_speed;
	if image_angle > 360 or image_angle < -360 {
		image_angle = move_strengthh * turn_speed;
	}
	
	x_comp = cos(image_angle*pi/180) * move_strengthv;
	y_comp = sin(image_angle*pi/180) * move_strengthv;
	
	
	velocity[0] += x_comp * delta_time / 1000000 * acc 
	if velocity[0] > max_speed or velocity[0] < -max_speed {
		velocity[0] = max_speed * sign(velocity[0]);	
	}
	velocity[1] += -y_comp * delta_time / 1000000 * acc
	if velocity[1] > max_speed or velocity[1] < -max_speed {
		velocity[1] = max_speed * sign(velocity[1]);	
	}
	
}

//Movement if you are a client
//	You face toward the mouse
//	WS move forward/backward relative to where you are looking
//	AD dash you left/right if red
//	Q dash you backwards if green
function multiplayer_movement() {
	//Forwards/backwards
	//
	//
	move_strengthv = keyboard_check(k_up) - keyboard_check(k_down);
	
	//Look towards mouse
	image_angle = point_direction(x, y, mouse_x, mouse_y);
	
	x_comp = (cos(image_angle*pi/180) * move_strengthv);
	y_comp = (sin(image_angle*pi/180) * move_strengthv);

	//Normalize the vector
	//	i.e divide the component by the magnitude
	if x_comp != 0 or y_comp != 0 {
		x_comp = x_comp / sqrt(abs((x_comp*x_comp) + (y_comp*y_comp)));
		y_comp = y_comp / sqrt(abs((x_comp*x_comp) + (y_comp*y_comp)));
	}
	
	//Dashing
	//	only dash after specified time (in seconds)
	//	red should only dash
	move_strengthh = 0;
	if dash_cooldown < 0 and ship_type == st.red {
		move_strengthh = keyboard_check_pressed(k_left) - keyboard_check_pressed(k_right);

		if move_strengthh != 0 { 
			//Dash
			x_comp = cos((image_angle+90)*pi/180) * max_speed * move_strengthh * 7.5
			y_comp = sin((image_angle+90)*pi/180) * max_speed * move_strengthh * 7.5
			dash_cooldown = 1; 
		}
		
	}
	
	//Change the velocity + cap speed
	velocity[0] += x_comp * delta_time / 1000000 * acc 
	if velocity[0] > max_speed or velocity[0] < -max_speed {
		velocity[0] -= delta_time / 1000000 * acc  * sign(velocity[0]);	
	}
	velocity[1] += -y_comp * delta_time / 1000000 * acc
	if velocity[1] > max_speed or velocity[1] < -max_speed {
		velocity[1] -= delta_time / 1000000 * acc  * sign(velocity[1]);	
	}
	
	//Dash cooldown
	if dash_cooldown >= 0 {
		dash_cooldown -= global.dt;
	}
}

//
//Connect to provided ip and port
//
function connect_to_server(ip, port) {
	//Timeout of 3 seconds
	network_set_config(network_config_connect_timeout, 3000);
	is_client = true;
	socket = network_create_socket(network_socket_tcp);
	state = pstates.dead;
	
	client_buffer = buffer_create(1024, buffer_fixed, 1);

	socket_map = ds_map_create();
	ds_map_add(socket_map, socket, id);
	
	//if socket = -1 , there is an error
	if (socket < 0) {
		show_message("Error connecting");	
		is_client = false;
	}
	
	recieved_socket = 0;

	if network_connect(socket, ip, port) < 0 {
		show_message("Error connecting - likely invalid IP or port");
		is_client = false;
		room_goto(MainMenu);
		return -1;
	}


	
	//This sends the type information of the player
	//this is now disabled as "set_player" is sent as the newly joining client
	/*
	buffer_seek(client_buffer, buffer_seek_start, 0);
	buffer_write(client_buffer, buffer_u8, network.set_player);
	buffer_write(client_buffer, buffer_u8, network.toserver);
	buffer_write(client_buffer, buffer_u8, global.ship_type1);
	buffer_write(client_buffer, buffer_string, global.username1);
	
	network_send_packet(socket, client_buffer, buffer_tell(client_buffer));
	*/
	
}



//memory management for the server deletion
function disconnect_from_server() {
	network_destroy(socket);
	ds_map_destroy(socket_map);
	buffer_delete(client_buffer);
	
	if instance_exists(obj_Server) {
		with (obj_Server) {
			ds_list_destroy(socket_list);
			buffer_delete(server_buffer);
			network_destroy(server);
		}
	}	
}

//Changes variables depending on the selected weapon
function set_weapon(weapon) {
	selected_weapon = weapon;
	switch selected_weapon {
		
		//Normal gun
		case weapons.rifle:
			shoot_condition = keyboard_check;
			bullet_anglefunc = get_facingdirection
			bullet_sound = sndARShoot;
			damage = base_damage;
			shoot_speed = 0.0875;
			bullet_yscale = 1;
			bullet_xscale = 1;
			break;
		
		//Single shoot, high damage, low reload
		case weapons.revolver:
			shoot_condition = keyboard_check_pressed;
			bullet_anglefunc = get_facingdirection
			bullet_sound = sndARShoot;
			damage = base_damage * 3;
			shoot_speed = 0.14;
			bullet_xscale = 2;
			bullet_yscale = 2;
			break;
			
		//Auto, low damage, high reload
		case weapons.minigun:
			shoot_condition = keyboard_check;
			bullet_anglefunc = get_directionrandom
			bullet_sound = sndMinigunShoot;
			damage = base_damage * 0.5;
			shoot_speed = 0.015;
			bullet_xscale = 0.5;
			bullet_yscale = 0.5;
			break;
			
	}
}

//Intended for bullets
function get_facingdirection() {
	return image_angle	
}

function get_directionrandom() {
	return irandom_range(image_angle-30/2, image_angle+30/2);	
}

//Moves player to a given index of a client
function spectate(index) {
	if is_client == true and dead == true and instance_exists(obj_Client) {
		index = clamp(index, 0, instance_number(obj_Client)-1);
		var _inst = instance_find(obj_Client, index);
		spec_inst = _inst;
		if _inst.dead == false {
			x = _inst.x;
			y = _inst.y;
		}
	}
}

//Increments the spec_player by val
function change_spec(val) {
	spec_player += val
	if spec_player > instance_number(obj_Client)-1 {
		spec_player = 0;	
	}
	else if spec_player < 0 {
		spec_player = instance_number(obj_Client)-1;
	}
}

is_client = false;
_accs = 2

win_count = 0;

//Red's : ship_type 1
red_speed = 8 *_accs
red_damage = 11
red_health = 600

//Greens's : ship_type 2
green_speed = 4 * _accs
green_damage = 6.3
green_health = 1000

//Blue's : ship_type 3
blue_speed = 3 * _accs
blue_damage = 10
blue_health = 1178;

//Cooldowns
//	each of these count down every second when above 0
//	they all control something important
//	dont touch pls
shoot_cooldown = 0;
dash_cooldown = 0;
secondary_cooldown = 0;
_destroyed_secondary = false; //This is so secondaries arent destroyed every frame
action_cooldown = 0;
action_active = false;
action_count = global.action_count; //Variable for limiting the number of actions the player can perform

max_speed = 5;

//Overheating; shoot more = overheat increases
heat = 0;
max_heat = 10;
ammo = 1;
max_ammo = 10;
cooled = true; //Can only shoot again when cooled

//Every reset sends the players here
start_x = 0;
start_y = 0;

//Default ship type
hlth_bar = undefined;
ammo_bar = undefined;
action_bar = undefined;
respawn_timer = undefined;

//Life system
//(spelt with f because v is taken)
//if you run out of lives, death
//	otherwise, try to respawn far from other players
lifes = global.lifes;

//
//Particles
//

parTypeShoot = part_type_create();
parTypeTrail = part_type_create();
parTypeDeath = part_type_create();


set_type(global.ship_type1, "", 100, 100);

bullet_func = scr_CreateBullet //How the player should create a projectile : default = normal bullet
bullet_spd = 72;
selected_weapon = weapons.rifle;
shoot_speed = 0.07;
bullet_xscale = 1;
bullet_yscale = 1;
bullet_anglefunc = get_facingdirection
bullet_sound = sndARShoot;
set_weapon(selected_weapon);
//secondary_func = scr_PlayerShockwave


player_number = obj_PlayerManager.total_players + 1;
obj_PlayerManager.total_players += 1;

x = start_x;
y = start_y;

mass = 2; //Defines the amlitued of a bounce (higher number = greater bounce)

//MOVEMNENT
velocity = [0,0];

dead = false;
respawning = false; //needed so the respawn timer does not draw or respawn the player when the player actually dies
//spectating = false;
spec_player = 0;
spec_inst = id;
//scr_Death();

//
//Controls
//

k_action = ord("Q");
k_secondary = ord("E");
k_up = ord("W");
k_down = ord("S");
k_left = ord("A");
k_right = ord("D");
k_shoot = vk_space;
k_weapon1 = ord("1");
k_weapon2 = ord("2");
k_weapon3 = ord("3");

//Controls if other player
if player_number > 1 {
	k_action = ord("I");
	k_secondary = ord("P");
	k_up = vk_up;
	k_down = vk_down;
	k_left = vk_left;
	k_right = vk_right;
	k_shoot = ord("O");
	k_weapon1 = ord("8");
	k_weapon2 = ord("9");
	k_weapon3 = ord("0");
}

