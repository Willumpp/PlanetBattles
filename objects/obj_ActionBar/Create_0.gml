fraction = 1;
fraction_shield = 0;
fraction_acount = 1;


function set_parent(par) {
	parent = par
	parent.action_bar = id;
}

//parent = instance_find(obj_Player, parent_number); //Find connection
parent = undefined;

function update_bar() {
	if parent != undefined {
		fraction = parent.action_cooldown/12;
		fraction_acount = parent.action_count/global.action_count;
	}
}
