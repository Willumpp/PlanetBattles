//x += velocity_x;
//y += velocity_y;

//Taking damage from bullets
/*
var bullet = scr_TagCollision(x,y,"bullet")
if bullet != undefined and bullet.player != id {
	instance_destroy(bullet)
}
*/

//Taking damage from bullets
var bullet = scr_TagCollision(x,y,"bullet");
if bullet != undefined and bullet.player != id and shield_active == false {
	instance_destroy(bullet.id);
}
//This is for detecting if the shield is active to deflect the bullet
//acts the same as it did before but with a nice bouncing effect
else if bullet != undefined and bullet.player != id {
	var _dir = point_direction(bullet.x, bullet.y, x, y);
	bullet.direction = _dir+180;
	bullet.image_angle = _dir+180;
}

//
//Particles
//

parSelfTrail(parTypeTrail, 0.1, sprite_index);
if dead == false {
	parCreate(global.parSys, x, y, parTypeTrail, 1);
}