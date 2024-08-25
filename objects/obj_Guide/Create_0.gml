//This should work as a powerpoint presentation
slide_n = 0;
title = "test";
text = @"testing
more testing";
image = spr_Title;
max_slides = 10;

//Each slide should have title, text, and an image
function change_slide(slide) {

	slide_n = slide;
	//slide_n = clamp(slide, 0, 3);
	//clamp + loop slides
	if slide_n > max_slides {
		slide_n = 0;	
	}
	if slide_n < 0 {
		slide_n = max_slides;	
	}
	
	switch slide_n {
		//"Ships"
		case 0:
			title = "Ships";
			text = 
@"Ships have basic blaster controlled by SPACE and 
basic movement controlled by W and S 
(forward and backwards relative to the direction the ship is facing).
 
Aiming is controlled by the cursor's position. 
As well as the basic blaster, Ships also have abilities controlled by Q and E. 
(Q has cooldowns whereas E has Ammo/Energy).";
			image = spr_SlideShips;
			imgxoffset = 0;
			imgyoffset = 64;
			break;
			
		case 1:
			title = "Blaster";
			text =
@"All ships have a basic Blaster.
The Blaster has three modes:

A semi-automatic shotgun,
a medium power assault rifle, 
and a very fast minigun. ";
			image = spr_SlideBlaster;
			imgxoffset = 0;
			imgyoffset = 0;
			break;
			
		case 2:
			title = "Ship Integrity";
			text =
@"Ship Integrity is a measure of your ship's current integrity, 
essentially functioning as a health bar.

Ship Integrity does not naturally regenerate, but can be
regained with certain abilities, and added to by others.";
			image = spr_SlideShipIntegrity;
			imgxoffset = 0;
			imgyoffset = 0;
			break;
			
		case 3:
			title = "Ablilities";
			text =
@"Each ship has abilities that can be activated
by Q and E, Q being tactical and E being offensive.
Red also has the bonus ability to dash with A/D.

Red: Q - Meteor Missile, E - Energy Rain
Green: Q - Meteor Shield, E - Homing Rockets
Blue: Q - Energy Shield, E - Laser";
			image = spr_SlideAbilities;
			imgxoffset = 0;
			imgyoffset = 96;
			break;
			
		case 4:
			title = "Meteors";
			text =
@"Meteors float around the map and can collide with the player.
Meteor collisions do not damage the player, however due to 
the mass of the meteor, players cannot push meteors, only
be pushed by meteors.

Meteors are mostly indestructible and block most projectiles,
with only the Red ship variant being able to destroy and
shoot through Meteors.";
			image = spr_SlideMeteors;
			imgxoffset = 0;
			imgyoffset = 96;
			break;
			
			
		case 5:
			title = "Ammo Pickups";
			text = 
@"Ammo pickups can spawn different amounts of
ammo within, and the closer to the player colour
they are the more ammo they contain

Ammo pickups spawn every 10 seconds,
and are limited to only 5 existing on the map at any given time
"
			image = spr_SlideAmmoPickups;
			imgxoffset = 0;
			imgyoffset = 0;
			break;
			

			
		case 6:
			title = "The Map";
			text =
@"The map is a useful tool that displays the positions of other players, 
ammo pickups, and wormholes.

Player positions are not constantly updated to add 
a level of strategy to the map.";
			image = spr_SlideMap;
			imgxoffset = 0;
			imgyoffset = 128;
			break;
			
		case 7:
			title = "Wormholes";
			text =
@"Wormholes can spawn around the map in pairs, with their
map icons being that of the colours they are made up of.

Wormholes are single use, and are destroyed when a player
goes through. Wormholes destroy everything except from
black holes, which can destroy wormholes.";
			image = spr_SlideWormholes;
			imgxoffset = 0;
			imgyoffset = 128;
			break;
			
		case 8:
			title = "Gamma-ray bursts";
			text =
@"Gamma ray bursts are an event that can occur in one of
the four corners of the map.

Gamma ray burst events are a lot of individual bursts
in a specific area that cause massive damage to any player
who happens to get caught within.";
			image = spr_SlideGRB;
			imgxoffset = 0;
			imgyoffset = 128;
			break;
			
		case 9:
			title = "Black Holes";
			text =
@"Black Holes are a rare event limited to one at any given time.
Black Holes spawn in the centre of the map, pushing away players,
ammo pickups and meteors upon their generation.


Once generated, they start to pulling everything towards themselves.
Nothing survives the Black Holes. They Consume All.";
			image = spr_SlideBlackhole;
			imgxoffset = 0;
			imgyoffset = 128;
			break;
			
		case 10:
			title = "HUD";
			text = @"";
			image = spr_SlideHUD;
			imgxoffset = 0;
			imgyoffset = view_hport[0]/2 - (view_hport[0]-256*global.scscale- sprite_get_height(spr_SlideHUD)/2);
			break;
			
	}
	
}

change_slide(0)