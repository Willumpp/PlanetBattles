function scr_EventCreate(objid, intensity, duration, evseed, quadrant, xpos, ypos) {
	var _inst = instance_create_layer(xpos, ypos, "Players", objid);
	_inst.set_intensity(intensity);
	//_inst.intensity = intensity;
	if duration != -1 {
		_inst.duration = duration; //+= to add onto the warning
	}
	else {
		_inst.enable_duration = false;
	}
	_inst.quadrant = quadrant;
	
	//ds_list_read(_inst.args, args);
	_inst.set_seed(evseed);
}