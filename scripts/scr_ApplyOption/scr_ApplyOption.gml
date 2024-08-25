
// Pass in the option name and the selected value of the options
function scr_ApplyOption(opt_name, selected) {
	var _moptions = global.moptions;
	var values = _moptions[? opt_name][? "values"][| selected];
	
	switch opt_name {
		//Changes the resolution of the game
		//	changes gui size
		//	window size
		//	window centre
		//	application surface
		//	viewport size
		case "Resolution":
			var aspect = 1080/1920

			//The input width and height
			inpwidth = values[| 0];
			inpheight = values[| 1];

			width = inpwidth;
			height = width * aspect; //Scale the width so 16:9 ratio holds

			global.scwidth = width;
			global.scheight = height;
			global.scinpwidth = inpwidth;
			global.scinpheight = inpheight;
			global.scscale = width/1920; //This is used to scale gui elements

			global.fntsize3 = fnt_Nasalization36;
			
			view_wport[0] = width;
			view_hport[0] = height;
			
			break;
			
		case "Fullscreen":
			window_set_fullscreen(bool(values));
			break;
			
		case "Glow":
			global.enableglow = values;
			break
			
		case "Particles":
			global.enableparticles = values;
			break
			
		case "Map Size":
			global.roomwidth = values[| 0];
			global.roomheight = values[| 1];
			break;
			
		case "Unlimited Ammo":
			global.unlimited_ammo = bool(values);
			break;
			
		case "Health Multiplier":
			global.health_multiplier = values;
			break;
			
		case "Damage Multiplier":
			global.damage_multiplier = values;
			break;
			
		case "Meteor Size":
			global.meteor_scale = values;
			break;
			
		case "Meteor Rate":
			global.meteor_rate = values;
			break;
			
		case "Lives":
			global.lifes = values;
			break;
			
		case "Music Volume":
			global.music_volume = values;
			break;
			
		case "SFX Volume":
			global.sfx_volume = values;
			break;
			
		case "Meteor Collision":
			global.meteor_collision = values;
			break;
			
		case "Ammo Rate":
			global.ammo_rate = values;
			break;
			
		case "Ammo Count":
			global.ammo_count = values;
			break;
			
		case "Action Count":
			global.action_count = values;
			break;
			
		case "Random Events":
			global.event_rate = values;
			break;
			
		case "Warnings":
			global.warnings_active = values;
			break;
			
		case "Wormhole Count":
			global.wormhole_count = values;
			break;
			
		case "Wormhole Rate":
			global.wormhole_rate = values;
			break;
			
		case "applied_ship_options":
			global.applied_ship_options = values;
			break;
			
		case "showed_warning":
			global.showed_warning = values;
			break;
	}
	
	
}