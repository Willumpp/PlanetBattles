// Return in collision box is outside of walls
// additionally returns the direction
// 0 : right, 1 : up, 2 : left, 3 : down , -1 : false
function scr_WallCollision(scalar){
	//bbox = "bouding box"
	//	it is the collision box's coordinates at a specified edge
	//Right
	if bbox_right + velocity[0] > room_width { 
		velocity[0] = -scalar
		return 0;
	}
	//Left
	else if bbox_left + velocity[0]  < 0 {
		velocity[0] = scalar
		return 2;
	}
	//Bottom
	else if bbox_bottom + velocity[1]  > room_height {
		velocity[1] = -scalar
		return 3;
	}
	//Top
	else if bbox_top + velocity[1] < 0 {
		velocity[1] = scalar
		return 1;
	}
	else {
		return -1;	
	}
	
}

function scr_WallCollision2() {
	//bbox = "bouding box"
	//	it is the collision box's coordinates at a specified edge
	//Right
	if bbox_right + velocity[0] > room_width { 
		velocity[0] = -velocity[0]
		return 0;
	}
	//Left
	else if bbox_left + velocity[0]  < 0 {
		velocity[0] = -velocity[0]
		return 2;
	}
	//Bottom
	else if bbox_bottom + velocity[1]  > room_height {
		velocity[1] = -velocity[1]
		return 3;
	}
	//Top
	else if bbox_top + velocity[1] < 0 {
		velocity[1] = -velocity[1]
		return 1;
	}
	else {
		return -1;	
	}
	
}
