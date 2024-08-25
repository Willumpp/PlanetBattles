
//Give a player ammo when colliding
var _coll = scr_TagCollision(x, y, "player");

if _coll != undefined {
	
	instance_destroy();
	with _coll {
		set_ammo(ammo + other.quantity);	
	}
}

var _coll = scr_ObjectCollision(x+velocity[0], y+velocity[1], obj_Asteroid, "")
if _coll != undefined { //If colliding with an object
	//Get direction to object
	var _dir = point_direction(_coll.x, _coll.y, x, y);
	var _mag = sqrt(sqr(_coll.velocity[0]) + sqr(_coll.velocity[1]))
	
	//Create new velocity x and y component in response
	x_comp = _mag * cos(_dir*pi/180)
	y_comp = _mag * sin(_dir*pi/180)
	velocity[0] = x_comp 
	velocity[1] = -y_comp
}

x += velocity[0]
y += velocity[1]

image_angle += rotate_speed;

//Destroy if outside room
if x < 0 or x > room_width or y > room_height or y < 0 {
	instance_destroy();	
}