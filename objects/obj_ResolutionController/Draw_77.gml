//Post draw so it draws last
//	apply screen shader
if global.enableglow {
	shader_set(shGlow);
	//shader_set(shTint);
	shader_set_uniform_f(utexH, texH);
	shader_set_uniform_f(utexW, texW);
	//The surface needs drawing with an offset so the black bars are even on top and bottom
	draw_surface(application_surface, 0, (inpheight-height)/2);
	shader_reset();
}
else {
	//The surface needs drawing with an offset so the black bars are even on top and bottom
	draw_surface(application_surface, 0, (inpheight-height)/2);
}