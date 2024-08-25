


//Asteroid/object collision
var _coll = scr_ObjectCollision(x, y, obj_Asteroid, "")
if _coll != undefined { //If colliding with an object
	
	//Get direction to object
	var _dir = point_direction(x, y,_coll.x, _coll.y);
	var _mag = sqr(xdraw_scale*ydraw_scale)/2;
	
	//Create new velocity x and y component in response
	with _coll {
		x_comp = _mag * cos(_dir*pi/180)
		y_comp = _mag * sin(_dir*pi/180)
		velocity[0] += x_comp 
		velocity[1] += -y_comp
		//coll_info();
	}
	
	parPew(parTypeDestroy, c_white, image_angle-180, 0.05, 0.5);
	parCreate(global.parSys, x, y, parTypeDestroy, 5);
	instance_destroy(id);	
}

//Destroy if colliding with asteroid
//old code, now bullets should slightly push meteor also
//currently enabled until meteor pushing is fine-tuned;
if scr_ObjectCollision(x,y, obj_Asteroid,"") {
	
	parPew(parTypeDestroy, c_white, image_angle-180, 0.05, 0.5);
	parCreate(global.parSys, x, y, parTypeDestroy, 5);
	
	instance_destroy(id);	
}



//Destroy if outside room
if x < 0 or x > room_width or y > room_height or y < 0 {
	instance_destroy(id);	
}

