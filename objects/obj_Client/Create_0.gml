velocity_x = 0;
velocity_y = 0;
ship_type = 0;
dead = false;
is_client = false;
username = "";
start_x = 0;
start_y = 0;
bullet_func = scr_CreateBullet
bullet_spd = 72;
hlth = 0;
hlth_bar = undefined;
ammo_bar = undefined;
base_health = 1;
shield_active = false;
heat = 0;
shield_health = 0;
max_heat = 10;
ammo = 0;
max_ammo = 10;
win_count = 0;
action_active = false;
velocity = [0, 0] //This is not used for any movement, it is for calculating anything such as bounces
action_bar = undefined;

//
//Particles
//
parTypeTrail = part_type_create();
parTypeShoot = part_type_create();
parTypeDeath = part_type_create();


asset_add_tags(id, "player", asset_object);

function set_health(val) {
	hlth = val;	
}
function set_ammo(val) {
	ammo = val;	
}

//Changes variables for ship types
function set_type(type, name, startx, starty) {
	ship_type = type;
	username = name;
	start_x = startx;
	start_y = starty;
	
	//1: red, 2: green, 3: blue
	switch type {
		case st.red:
			sprite_index = spr_Player1;
			break;
			
		case st.green:
			sprite_index = spr_Player2;
			break;	
			
		case st.blue:
			sprite_index = spr_Player3;
			break;	
		
	}
	
}