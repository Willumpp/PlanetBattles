//Set up health bar connection
fraction = 1;
fraction_shield = 0;


function set_parent(par) {
	parent = par
	parent.hlth_bar = id;
}

//parent = instance_find(obj_Player, parent_number); //Find connection
parent = undefined;

function update_bar() {
	if parent != undefined {
		fraction = parent.hlth/parent.base_health;
	}
}
function update_shield() {
	if parent != undefined {
		fraction_shield = parent.shield_health/parent.base_health; //12 is base health of the shield
	}
}
total_bars = 10;