draw_set_font(fnt_Nasalization12);
draw_set_halign(fa_left);
draw_text(x, y-32, "Ship Integrity: ");

var health_colour = scr_GetColour(parent.ship_type);

//Draws the health bar as an "actual bar"
//	320 = width of health bar
scr_PartBar(spr_HealthBar, sprite_width*fraction, sprite_height, health_colour);

//Draw shield bar
scr_PartBar(spr_HealthBar, sprite_width*fraction_shield, sprite_height, c_teal);

//additionally show the selected weapon
//show_debug_message(weapons.rifle)
draw_sprite(spr_FireMode2, 0, x+360+48, y);
draw_sprite(spr_FireMode1, 0, x+360, y);
draw_sprite(spr_FireMode3, 0, x+360+48+48, y);

var xoffset = 0;
//Box selection
switch parent.selected_weapon {
	
	case weapons.rifle:
		xoffset = 48;
		break;
	case weapons.revolver:
		xoffset = 0;
		break;
	case weapons.minigun:
		xoffset = 96;
		break;
}
draw_rectangle(x+360+xoffset, y, x+360+32+xoffset, y+32, true);