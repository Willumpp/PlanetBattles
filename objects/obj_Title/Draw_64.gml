
shader_set(shGlow);
//Set the rgba of the shader

switch global.ship_type1 {
	case st.red:
		draw_sprite(spr_TitleRed, 0, x, y);
		break;
	case st.green:
		draw_sprite(spr_TitleGreen, 0, x, y);
		break;
	case st.blue:
		draw_sprite(spr_TitleBlue, 0, x, y);
		break;
}	


shader_set_uniform_f(utexH, texH);
shader_set_uniform_f(utexW, texW);
DrawCollisionBox()
shader_reset();
