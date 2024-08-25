/*
if keyboard_check_pressed(ord("G")) {
	event_cooldown = event_rate;
	event_seed = int64(date_get_second_of_year(date_current_datetime()))+1;
	
	//var _event = get_event();
	
	var _event = event.grb
	event_quad = irandom_range(0, 3);
	var _set = set_event(_event, event_quad);

	if _set == true {
		scr_StartEvent(_event, event_seed, event_quad, event_xpos, event_ypos);
	}
}
*/
// or keyboard_check_pressed(ord("B"))
//Events are independent from wormholes
if event_cooldown < 0 or keyboard_check_pressed(ord("B")){
	event_cooldown = event_rate;
	event_seed = int64(date_get_second_of_year(date_current_datetime()))+1;
	
	var _event = get_event();
	
	//var _event = event.grb
	event_quad = irandom_range(0, 3);
	var _set = set_event(_event, event_quad);

	if _set == true {
		scr_StartEvent(_event, event_seed, event_quad, event_xpos, event_ypos);
	}
}
else if instance_exists(obj_Server) and obj_Server.state = server_states.in_game {
	event_cooldown -= global.dt * global.event_rate;
}
else if !instance_exists(obj_Server) {
	event_cooldown -= global.dt * global.event_rate;	
}







//Wormholes are independent from the even pool
if (wormhole_cooldown < 0 and instance_number(obj_Wormhole) < global.wormhole_count*2) or keyboard_check_pressed(ord("N")) {
	wormhole_cooldown = wormhole_rate;
	event_seed = int64(date_get_second_of_year(date_current_datetime()))+1;
	
	var _event = event.wormhole;
	_quad = irandom_range(0, 3);
	set_event(_event, _quad);

	//scr_StartEvent(_event, event_intensity, event_duration, event_seed, _quad, event_xpos, event_ypos);
	scr_StartEvent(_event, event_seed, _quad, event_xpos, event_ypos);
}
else {
	wormhole_cooldown -= global.dt * global.wormhole_rate;	
}