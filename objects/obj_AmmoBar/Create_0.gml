//Ammo bar fraction
fraction = 1;

//Set the parent (typically called by "player_manager")
function set_parent(par) {
	parent = par
	parent.ammo_bar = id;
}

parent = undefined;
player1 = true;
text = "Ammo: ";
colour = c_teal;

//Called by player when the ammo is decreasing
//	calculates a % of amoo
function update_bar() {
	if parent != undefined {
		fraction = parent.ammo/parent.max_ammo;
	}
}
total_bars = 10;