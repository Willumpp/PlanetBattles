// This script is for creating a bullet
//	each ship should do this, passing in speed, damage, and sprite
function scr_CreateBigBullet(spd, damage) {
	//We want to create the bullet at the end of the ship
	var xoffset = cos(image_angle*pi/180) * sprite_width/2;
	var yoffset = sin(image_angle*pi/180) * sprite_width/2;
	
	var bullet = instance_create_layer(x+xoffset,y-yoffset,"Players",obj_BBullet);
	bullet.colour = scr_GetColour(ship_type);
	bullet.direction = image_angle;
	bullet.image_angle = image_angle;
	bullet.speed = spd;
	bullet.damage = damage;
	bullet.player = id;
}