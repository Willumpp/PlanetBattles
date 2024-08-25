// Creates homing bullet
//	finds closet player, homes in, and kills
function scr_HomingBullet() {
	//We want to create the bullet at the end of the ship
	var xoffset = cos(image_angle*pi/180) * sprite_width/2;
	var yoffset = sin(image_angle*pi/180) * sprite_width/2;
	
	var _bullet = instance_create_layer(x+xoffset, y-yoffset, "Players", obj_HomingBullet);
	_bullet.direction = image_angle;
	_bullet.image_angle = image_angle;
	_bullet.player = id;
	_bullet.colour = scr_GetColour(ship_type);
	_bullet.speed = bullet_spd/2;
}