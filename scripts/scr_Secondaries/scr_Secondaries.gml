// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_Secondaries(){
	
}

//Creates a big laser accross the entire map lol
function scr_BigLaser() {
	var _bullet = instance_create_layer(x, y, "Players", obj_Laser);
	_bullet.player = id;
	_bullet.image_angle = image_angle;
}

function scr_Blank(){
	show_debug_message("insert epic action");
}

// Creates bullet spray
//	sprays bullets
function scr_BounceArmada() {
	var armada = instance_create_layer(x, y, "Players", obj_BounceArmada);
	armada.player = id;
}

// Creates bullet spray
//	sprays bullets
function scr_EnergySpray() {
	var tunnel = instance_create_layer(x, y, "Players", obj_EnergySpray);
	tunnel.player = id;
}

// Creates homing bullet
//	finds closet player, homes in, and kills
function scr_HomingBulletBarrage() {
	var barrage = instance_create_layer(x, y, "Players", obj_HomingBarrage);
	barrage.player = id;
}

// Creates a "shockwave" around the player that does aoe damage
//	typically used with blue
function scr_PlayerShockwave() {
	var _shock = instance_create_layer(x, y, "Players", obj_Shockwave);
	_shock.player = id;
}
