
function scr_PlayerReset(){
	visible = false;
	set_type(ship_type, username, start_x, start_y);
	x = start_x;
	y = start_y;
	heat = 0;
	action_active = false;
	shield_active = false;
	//action_count = global.action_count;
	action_cooldown = 0;
	secondary_cooldown = 0;
	if action_bar != undefined { action_bar.update_bar(); }
	if hlth_bar != undefined { hlth_bar.update_bar(); hlth_bar.update_shield(); }
	set_ammo(max_ammo);
	velocity = [0,0];
	visible = true;
	dead = false;
	state = pstates.alive;
}