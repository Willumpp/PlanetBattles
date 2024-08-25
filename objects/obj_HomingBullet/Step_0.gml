
//Find the second nearest player
//	*second nearest to not target the parent player
//make sure the player is nearby
//normal instance find if the types arent the same
var _target;
_target = instance_nth_nearest("player", 1, player, max_distance);
target = _target;

if target == player { target = undefined; } //Ensure the target is not the player

//Particles
parFire(obj_PartController.parfire);
parCreate(global.parSys, x, y, obj_PartController.parfire, 2);


//Destroy if colliding with asteroid
/*
if scr_ObjectCollision(x,y, obj_Asteroid,"") {
	instance_destroy(id);	
}
*/
//its now required for the bullet to bounce off stuff?

//in order to bounce, I must take control of velocity
velocity = [cos(-direction*pi/180) * spd, sin(-direction*pi/180) * spd];

//Asteroid/object collision
var _coll = scr_ObjectCollision(x+velocity[0], y+velocity[1], obj_Asteroid, "")
if _coll != undefined { //If colliding with an object

	//Get direction to object
	var _dir = point_direction(_coll.x, _coll.y, x, y);
	var _mag = sqrt(sqr(velocity[0]) + sqr(velocity[1]))
	
	//Create new velocity x and y component in response
	x_comp = _mag * cos(_dir*pi/180)
	y_comp = _mag * sin(_dir*pi/180)
	direction = _dir;

	velocity[0] = x_comp 
	velocity[1] = -y_comp

}

if place_meeting(x, y, obj_Shield) {
	can_target = false;	
}

//Destroy if outside room
if x < 0 or x > room_width or y > room_height or y < 0 {
	instance_destroy(id);	
}


if target != undefined and can_target == true {
	gradually_turn(id, target, 100, 100);
	image_angle = direction
}

x += velocity[0] * global.dt * 50
y += velocity[1] * global.dt * 50