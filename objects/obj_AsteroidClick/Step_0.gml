//Allow asteroids to bounce of mouse
if mouse_check_button(mb_right) { 
	
	var _coll = scr_ObjectMeeting(mouse_x, mouse_y, obj_Asteroid)
	if _coll != undefined {//If colliding with an object
		_coll.velocity[0] = mouse_x - _coll.x;
		_coll.velocity[1] = mouse_y - _coll.y;
		/*
		//Get direction to object
		var _dir = point_direction(_coll.x, _coll.y, mouse_x, mouse_y) + 180;
	
		//Create new velocity x and y component in response
		var magnitude = sqrt(sqr(_coll.velocity[0]) + sqr(_coll.velocity[1]))
		x_comp = magnitude * 2 * cos(_dir*pi/180)
		y_comp = magnitude * 2 * sin(_dir*pi/180)
		_coll.velocity[0] = x_comp
		_coll.velocity[1] = -y_comp
		*/
	}
}