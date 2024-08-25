if respawn_cooldown > 0 {
	respawn_cooldown -= global.dt;
}
if respawn_cooldown <= 0 and player != undefined and player.respawning == true {
	//respawn_cooldown = 3;
	
	with obj_Player {
		scr_PlayerRespawn(room_height/(instance_number(obj_Client)+1));
	}
}