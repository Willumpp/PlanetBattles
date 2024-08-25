y = 64 * global.scscale;
x = view_wport[0] - 64 * global.scscale;

menu_visible = false;
sc = global.scscale;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_Nasalization18);
draw_set_valign(fa_top);
text = @"Meteor Rate - The rate at which meteors are generated.

Meteor Collision - Dictates whether or not meteors 
collide with each other.

Random Events - Dictates how frequently Random Events occur.

Ammo Rate - The rate at which ammo pickups spawn.

Ammo Count - The number of ammo pickups that can be on the map at any given time

Action Count - The amount of Defensive abilities each player has per life";