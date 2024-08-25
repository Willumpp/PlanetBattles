drain_time -= global.dt; //Decrement death timer

//Move to the parent
x = player.x; 
y = player.y;

//Find the second nearest player
//	*second nearest to not target the parent player
//make sure the player is nearby
//normal instance find if the types arent the same
var _target;
_target = instance_nth_nearest("player", 1, player, max_distance);
target = _target;

//Delete self when the timer runs out
if drain_time <= 0 {
	instance_destroy();	
}

//Break connection if the player exceeds distance
if target != undefined and instance_exists(target) {
	player.set_health(player.hlth+global.dt);
	target.set_health(target.hlth-global.dt);
}