// Deletes secondaries etc relating to the player to avoid errors
function scr_PlayerChildrenCleanup(){
	//Cleanup with other objects
	with (obj_BounceArmada) {
		if player == other.id {
			instance_destroy()	
		}
	}
	with (obj_Laser) {
		if player == other.id {
			instance_destroy()	
		}
	}
	with (obj_HomingBarrage) {
		if player == other.id {
			instance_destroy()	
		}
	}
	with (obj_Lifedrain) {
		if player == other.id {
			instance_destroy()	
		}
	}
	with (obj_Shield) {
		if player == other.id {
			instance_destroy()	
		}
	}
	with(obj_Astershield) {
		if player == other.id {
			instance_destroy()	
		}
	}
}