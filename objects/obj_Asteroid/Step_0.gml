//Camera for frustum culling
var x1 = camera_get_view_x(cam) - delete_border;
var y1 = camera_get_view_y(cam) - delete_border;
var x2 = x1 + camera_get_view_width(cam) + delete_border + image_xscale*64;
var y2 = y1 + camera_get_view_height(cam) + delete_border + image_yscale*64;
//this is so matrix transformations are performed when off camera

if( !point_in_rectangle( x, y, x1, y1, x2, y2)) { 
	perform_calcs = false;
}
else {
	perform_calcs = true;
}

//Collide with other asteroids

if global.meteor_collision == true {
	var _coll = scr_ObjectCollision(x, y, obj_Asteroid, "")
	if _coll != undefined {//If colliding with an object

		//Get direction to object
		var _dir = point_direction(_coll.x, _coll.y, x, y) + 180;
	
		//Create new velocity x and y component in response
		var magnitude = sqrt(sqr(_coll.velocity[0]) + sqr(_coll.velocity[1]))
		x_comp = magnitude * cos(_dir*pi/180)
		y_comp = magnitude * sin(_dir*pi/180)
		_coll.velocity[0] = x_comp
		_coll.velocity[1] = -y_comp
		
	}
}

var _coll = scr_TagCollision(x,y,"player");
if _coll != undefined {
	//Get direction to object
	var _dir = point_direction(_coll.x, _coll.y, x, y);
	var _mag = sqrt(sqr(_coll.velocity[0]) + sqr(_coll.velocity[1]))
	
	if _coll.ship_type == st.blue {
			
		
		//Create new velocity x and y component in response
		x_comp = _mag * cos(_dir*pi/180)
		y_comp = _mag * sin(_dir*pi/180)
		velocity[0] = x_comp 
		velocity[1] = -y_comp
	}
}

//this is for sending the position of the asteroid to every client
//	this is here as a last option. Each asteroid now sends their position from the host to every client
//	this could be intensive on the network ( I am not sure)
//however, the benefit is huge syncing issues solved
/*
if send_server == true {
	var client_buffer = obj_Player.client_buffer;
	buffer_seek(client_buffer, buffer_seek_start, 0);
	buffer_write(client_buffer, buffer_u8, network.meteor_move);
	buffer_write(client_buffer, buffer_u8, network.toserver);
	buffer_write(client_buffer, buffer_s16, offset[0]);
	buffer_write(client_buffer, buffer_s16, offset[1]);
	buffer_write(client_buffer, buffer_s16, velocity[0]);
	buffer_write(client_buffer, buffer_s16, velocity[1]);
	buffer_write(client_buffer, buffer_u16, client_id);
	
	network_send_packet(obj_Player.socket, client_buffer, buffer_tell(client_buffer));
}