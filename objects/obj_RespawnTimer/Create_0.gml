respawn_cooldown = 0;
player = undefined;

function respawn(time) {
	if player != undefined {
		respawn_cooldown = time;
	}	
}