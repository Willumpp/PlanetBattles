player.action_active = false;
with (obj_Miniasteroid) {
	if parent == other.id {
		instance_destroy();	
	}
}