if player != undefined and instance_exists(player) {
	x = player.x
	y = player.y
}

//Destroy if all the asteriods are gone
if asteroids_dead == asteroid_n {
	player.action_active = false;
	instance_destroy();	
}
