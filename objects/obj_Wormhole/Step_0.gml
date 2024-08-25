
//Check player collisions
var _coll = scr_TagCollision(x, y, "player")
if _coll != undefined and _coll.dead == false and instance_exists(partner) {
	
	with partner {
		_coll.x = x;
		_coll.y = y;
		
		instance_destroy()	
	}
	instance_destroy()
}

//Asteroid/object collision
var _coll = scr_ObjectCollision(x, y, obj_Asteroid, "")
if _coll != undefined { //If colliding with an object
	instance_destroy(_coll);	
}

//Asteroid/object collision
var _coll = scr_TagCollision(x, y, "bullet")
if _coll != undefined { //If colliding with an object
	instance_destroy(_coll);	
}


_par_angle += 3;

var count = 10;
var colt = make_color_rgb(255-color_get_red(colour)/2, 255-color_get_green(colour)/2, 255-color_get_blue(colour)/2)
for (var i = 0; i < 360; i+=360/count) { 
	parStream(parTypeWormhole, colt, colour, _par_angle+i, 0.5, 0.1875, 10);
	parCreate(_parSys, x, y, parTypeWormhole, 1);
}

var colt2 = make_color_rgb(255-color_get_red(colour2)/2, 255-color_get_green(colour2)/2, 255-color_get_blue(colour2)/2)
for (var i = count; i < 360; i+=360/count) { 
	parStream(parTypeWormhole2, colt2, colour2, _par_angle+i, 0.5, 0.1875, 10);
	parCreate(_parSys, x, y, parTypeWormhole2, 1);
}

x += velocity[0]/10;
y += velocity[1]/10;

//Destroy if outside room
if x < 0 or x > room_width or y > room_height or y < 0 {
	instance_destroy(id);	
}
