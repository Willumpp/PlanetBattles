
//Get settings
width = global.scwidth;
height = global.scheight;
inpwidth = global.scinpwidth;
inpheight = global.scinpheight;

view_wport[0] = width;
view_hport[0] = height;
display_set_gui_size(width, height); //Changes the gui size?

//Scale application surface depending on fullscreen
if window_get_fullscreen() {
	surface_resize(application_surface, display_get_width(), display_get_height()) //Resizes the game surface to fit the screen
}
else {
	surface_resize(application_surface, width, height) //Resizes the game surface to fit the screen
}
window_set_size(inpwidth, height); //Sets the actual window of the game
window_center(); //Centers the application window in the middle of the monitor

//This is for shaders
application_surface_draw_enable(false);
utexW = shader_get_uniform(shGlow, "texW");
utexH = shader_get_uniform(shGlow, "texH");

texW = 1/ surface_get_width(application_surface);
texH = 1/ surface_get_height(application_surface);