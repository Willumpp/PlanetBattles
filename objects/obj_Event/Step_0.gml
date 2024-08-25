//custom "step"
if argpnt_cooldown < 0 and state == evstate.active {
	change_pnt(); //Custom function for each event
	
	argpnt_cooldown = argpnt_rate;
}
else {
	argpnt_cooldown -= global.dt;	
}


if duration < 0 and state == evstate.active and enable_duration == true {
	instance_destroy();
}
else if state == evstate.active {
	duration -= global.dt;	
}

if state == evstate.warning {
	_warning_fade += 4*global.dt;
}
