if scr_ButtonPress() {
	global.host_port = real(global.host_port);

	room_goto(rm_Host);
}