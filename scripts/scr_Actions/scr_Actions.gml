//Creates a "barrage" of asteroid destroying missiles
function scr_Missile(){
	var barrage = instance_create_layer(x, y, "Players", obj_MissileBarrage);
	barrage.player = id;
	obj_AudioController.sfx_play(sndred_missile, x, y);
}

// Creates an "astershield"
//	each asteroid blocks a projectile
function scr_Astershield(){
	action_active = true;
	
	var astershield = instance_create_layer(x, y, "Players", obj_Astershield);
	astershield.player = id;
	obj_AudioController.sfx_play(sndgreen_shield, x, y);
}

// Creates the shield object on the player
function scr_DestroyShield() {
	
		
	with (obj_Shield) {
		if player == other.id {
			instance_destroy();	
		}
	}
}

//Creates a "life drain"
//	drains life from the nearest player
function scr_Lifedrain() {
	var _shock = instance_create_layer(x, y, "Players", obj_Lifedrain);
	_shock.player = id;
}

//Blue's shield
//	barrier that increases health by x%
//	lasts until broken
function scr_Shield(){
	action_active = true; 
	if shield_active == false {
		shield_active = true;
		
		if object_index == obj_Player { 
			//heat += max_heat/2;
			shield_health = 176 * global.health_multiplier;;
			
			hlth_bar.update_shield()
		}
		
		//Create the visual shield
		var _shield = instance_create_layer(x, y, "Players", obj_Shield);
		_shield.player = id;
		obj_AudioController.sfx_play(sndblue_shield, x, y);
	}	
}