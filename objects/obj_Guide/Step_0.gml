//Collide image with asteroid
var sc = global.scscale;
var imgwidth = sprite_get_width(image);
var imgheight = sprite_get_height(image);
var _coll = collision_rectangle(room_width/2+imgxoffset - (imgwidth/sc)/2, room_height-256+imgyoffset,
			room_width/2+imgxoffset + (imgwidth/sc)/2, room_height-256+imgyoffset - (imgheight/sc), obj_Asteroid, false, true);	


if _coll != undefined and _coll != noone { //If colliding with an object
	//Get direction to object
	var _dir = point_direction(_coll.x, _coll.y, room_width/2+imgxoffset, room_height-256+imgyoffset - (imgheight/sc)/2) + 180;
	
	//Create new velocity x and y component in response
	var magnitude = sqrt(sqr(_coll.velocity[0]) + sqr(_coll.velocity[1]))
	x_comp = magnitude * cos(_dir*pi/180)
	y_comp = magnitude * sin(_dir*pi/180)
	_coll.velocity[0] = x_comp
	_coll.velocity[1] = -y_comp
	
}