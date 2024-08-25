enum event {
	ping,
	test,
	wormhole,
	grb, //gamma ray burst
	blackhole,
}

enum quad {
	ne,
	se,
	sw,
	nw,
	middle,
}

enum evstate {
	warning,
	active,
}

//This is for getting a position based on a quadrant
//	this one is the very corner of the room
function _quadrant_corner(qu) {
	switch qu {
		case quad.ne:
			event_xpos = room_width;
			event_ypos = 0;
			break;
		case quad.se:
			event_xpos = room_width;
			event_ypos = room_height;
			break;
		case quad.sw:
			event_xpos = 0;
			event_ypos = room_height;
			break;
		case quad.nw:
			event_xpos = 0;
			event_ypos = 0;
			break;
		case quad.middle:
			event_xpos = room_width/2;
			event_ypos = room_height/2;
			break;
	}
}

//This is for the randomisation of values in different events
function set_event(eventid, qu) {
	
	
	switch eventid {
		case event.grb:
			_quadrant_corner(qu)
			break;
		case event.blackhole:
			//This only allows one black hole at a given time
			if !instance_exists(obj_EvBlackhole) {
				event_quad = quad.middle;
				_quadrant_corner(event_quad);
			}
			else {
				event_cooldown = 0.1;
				return false;
			}
			break;
			
		default:
			break;
	}
	
	return true;
}	

function reset_events() {
	scr_EventCleanup();
	event_cooldown = event_rate;
}

//This is for weighing specific events,
//	e.g black hole 10% and grb 90%
function get_event() {
	var n = irandom_range(0, event_pool_total-1);
	var _total = 0;
	
	for (var i = 0; i < array_length(event_pool); i++) {
		_total += event_pool[i][0] 
		if n < _total { return event_pool[i][1]; }
	}
}

//Weigh specific events
event_pool = [
[1, event.blackhole],
[9, event.grb],
]
event_pool_total = 0;

for (var i = 0; i < array_length(event_pool); i++) {
	event_pool_total += event_pool[i][0]
}


event_seed = date_get_second(date_current_datetime());
event_rate = 50;
wormhole_rate = 7.5;
wormhole_cooldown = wormhole_rate;
event_cooldown = 0;
event_xpos = 0;
event_ypos = 0;
event_quad = quad.ne;

//event_args = ds_list_create(); //This is for additional data to send to the client

