intensity = 0;
quadrant = quad.nw;
_warning_fade = 0;
warning_text = "Event"

if global.warnings_active {
	state = evstate.warning;
}
else {
	state = evstate.active;	
}

argpnt_rate = 1; //represents how often a step is made
argpnt_cooldown = 0;
warning_duration = 4;

enable_duration = true;
duration = 1;

function change_pnt() {
	seed = my_random(seed, 10);
	return 0
}	

function set_intensity(val) {
	intensity = val;
}

function set_seed(val) {
	seed = val;	
}

function warning_end() {
	return 0	
}

seed = 3;

//Credit to https://www.youtube.com/watch?v=tkKX3KXC0WA&ab_channel=SamSpadeGameDev for this code
//need to use a custom random generator so each event for every player is in sync using this
function my_random(seed, range) {
	var a = 1103515245;
	var c = 12345;
	var m = power(2, 31);
	
	seed = ((a * seed) + c) % m;
	return (seed / m) * range
}