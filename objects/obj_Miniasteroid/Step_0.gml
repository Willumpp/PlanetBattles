//This shall orbit its parent at a given radius
if parent != undefined and instance_exists(parent) {
	var xpos = parent.x + cos(angle*pi/180) * radius
	var ypos = parent.y + sin(angle*pi/180) * radius
	
	x = xpos
	y = ypos
	
	angle += 1;
}

//Collide with projectiles
//	ensure not colliding with self
var _coll = scr_TagCollision(x, y, "bullet");
if _coll != undefined and instance_exists(_coll) and _coll.player != parent.player {
	with _coll { instance_destroy(); }
	hlth -= 1;
	
	//Destroy after x hits
	if hlth <= 0 {
		parent.asteroids_dead += 1; //Increment for eventual death
		instance_destroy()
	}
}