//Collide and bounce asteroids



//var _coll = scr_ObjectCollision(x, y, obj_Asteroid,"")
//draw_sprite(spr_Title, 0, x, y);
var posx = 1920/2;
var posy = 1080/2  - 284;
var _coll = collision_rectangle(posx-(sprite_width/2)/global.scscale, posy-(sprite_height/2)/global.scscale, 
								posx+(sprite_width/2)/global.scscale, posy+(sprite_height/2)/global.scscale, obj_Asteroid, false, true);	


if _coll != undefined and _coll != noone { //If colliding with an object
	//Get direction to object
	var _dir = point_direction(_coll.x, _coll.y, x, y) + 180;
	
	//Create new velocity x and y component in response
	var magnitude = sqrt(sqr(_coll.velocity[0]) + sqr(_coll.velocity[1]))
	x_comp = magnitude * cos(_dir*pi/180)
	y_comp = magnitude * sin(_dir*pi/180)
	_coll.velocity[0] = x_comp
	_coll.velocity[1] = -y_comp
	
}
