// This script is for creating a bullet
//	each ship should do this, passing in speed, damage, and sprite
function scr_CreateBullet(spd, damage, angle, xscale, yscale, soundid) {
	//We want to create the bullet at the end of the ship
	var xoffset = cos(image_angle*pi/180) * sprite_width/2;
	var yoffset = sin(image_angle*pi/180) * sprite_width/2;
	
	parPew(parTypeShoot, scr_GetColour(ship_type), image_angle, 0.05, 0.5);
	parCreate(global.parSys, x+xoffset, y-yoffset, parTypeShoot, 1);
	
	if instance_exists(obj_AudioController) { obj_AudioController.sfx_play(soundid, x, y); }
	
	var bullet = instance_create_layer(x+xoffset,y-yoffset,"Players",obj_Bullet);
	bullet.colour = scr_GetColour(ship_type);
	bullet.direction = angle;
	bullet.image_angle = angle;
	bullet.image_xscale = xscale;
	bullet.image_yscale = yscale;
	bullet.xdraw_scale = xscale;
	bullet.ydraw_scale = yscale;
	bullet.speed = spd;
	bullet.damage = damage;
	bullet.player = id;
}