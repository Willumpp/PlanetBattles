
//Destroy if colliding with asteroid
if scr_ObjectCollision(x,y, obj_Asteroid,"") {
	instance_destroy(id);	
}



//Destroy if outside room
if x < 0 or x > room_width or y > room_height or y < 0 {
	instance_destroy(id);	
}
