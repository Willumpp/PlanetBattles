//Bounce off stuff
//bounce bullets no longer bounce

/*
//Asteroid/object collision
var _coll = scr_ObjectCollision(x+velocity[0], y+velocity[1], obj_Asteroid, "")
if _coll != undefined { //If colliding with an object
	bounces += 1;
	
	//Get direction to object
	var _dir = point_direction(_coll.x, _coll.y, x, y);
	var _mag = sqrt(sqr(velocity[0]) + sqr(velocity[1]))
	
	//Create new velocity x and y component in response
	x_comp = _mag * cos(_dir*pi/180)
	y_comp = _mag * sin(_dir*pi/180)

	velocity[0] = x_comp 
	velocity[1] = -y_comp

}

//Wall Collision
scr_WallCollision2()
velocity[0] *= 0.99
velocity[1] *= 0.99

x += velocity[0] * global.dt * 100
y += velocity[1] * global.dt * 100

//Destroy after x many bounces
if bounces > 10 {
	instance_destroy(id); 
}
*/
//Asteroid/object collision
//now disabled
/*
var _coll = scr_ObjectCollision(x+velocity[0], y+velocity[1], obj_Asteroid, "")
if _coll != undefined { //If colliding with an object
	instance_destroy();	
}
*/
//Asteroid/object collision
var _coll = scr_ObjectCollision(x, y, obj_Asteroid, "")
if _coll != undefined { //If colliding with an object
	
	//Get direction to object
	var _dir = point_direction(x, y,_coll.x, _coll.y);
	var _mag = sqrt(sqr(velocity[0]) + sqr(velocity[1])) / 100;
	
	//Create new velocity x and y component in response
	with _coll {
		x_comp = _mag * cos(_dir*pi/180)
		y_comp = _mag * sin(_dir*pi/180)
		velocity[0] += x_comp 
		velocity[1] += -y_comp
	}
	
	instance_destroy(id);	
}

//Destroy if outside room
if x < 0 or x > room_width or y > room_height or y < 0 {
	instance_destroy(id);	
}

x += velocity[0] * global.dt * 100
y += velocity[1] * global.dt * 100

