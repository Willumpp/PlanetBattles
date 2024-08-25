
//Allows the player to return to hub
//	deducts a vote
if scr_ButtonPress(){
	obj_Player.disconnect_from_server();
	
	room_goto(MainMenu);
}
