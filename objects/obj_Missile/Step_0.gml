
//Find the second nearest player
//	*second nearest to not target the parent player
//make sure the player is nearby
//normal instance find if the types arent the same
var _target;
_target = instance_nearest(x, y, obj_Asteroid);
target = _target;

//Destroy if colliding with asteroid
//	also destroy the asteroid
var _coll = scr_ObjectCollision(x, y, obj_Asteroid, "");
if _coll != undefined {
	obj_ShakeController.shake(2, 2);
	with _coll { instance_destroy(); }
	
	//Create the energy cells:
	//	there is a miniscule change this could de-sync on multiplayer
	//	im hoping I dont need to get involved as the random values are too small to be impactful
	var count = irandom_range(3,5);
	var _dist;
	for (var i = 0; i < 360; i += 360/count) {
		var _cell = instance_create_layer(x, y, "Players", obj_EnergyCell);
		_dist = irandom_range(10,20);
		
		_cell.x = x + cos(i*pi/180) * _dist;
		_cell.y = y + sin(i*pi/180) * _dist;
		//Move towards the player?
		//	im not sure why this was requested lol
		_cell.direction = point_direction(x, y, player.x, player.y);
		_cell.speed = 1;
		_cell.player = player;
		_cell.colour = scr_GetColour(player.ship_type);
	}
	
	instance_destroy();	
}

//Destroy if outside room
if x < 0 or x > room_width or y > room_height or y < 0 {
	instance_destroy(id);	
}

//OPTIONAL homing
/*
if target != undefined and instance_exists(target) {
	gradually_turn(id, target, 100, 100);
	image_angle = direction
}
*/