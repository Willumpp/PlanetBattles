countdown -= global.dt;

if instance_exists(obj_Server) {
	if obj_Server.state = server_states.in_win_loss and countdown < 0 {
		with obj_RematchM { vote(5); }
	}
}