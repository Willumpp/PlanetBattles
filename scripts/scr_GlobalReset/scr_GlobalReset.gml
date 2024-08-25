//this will be used to reset the whole game for multiplayer and singleplayer
// we need to:
//	reset player(s)
//	reset clients(if multiplayer)
//	reset asteroids
function scr_GlobalReset(){
	if instance_exists(obj_Server) { 
		obj_Server.state = server_states.in_game;
		obj_Server.reset_clients(); 
	}
	obj_AsteroidGenerator.reset_asteroids();
	obj_PlayerManager.reset_players();
	obj_EventController.reset_events();
}