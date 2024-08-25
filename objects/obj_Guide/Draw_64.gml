var sc = global.scscale;

//-----Title

draw_set_font(global.fntsize3)
draw_set_halign(fa_center);
scr_TitleWithLines(title, scr_GetColour(global.ship_type1))


//Info
draw_set_color(c_white);
draw_set_font(fnt_Nasalization24)
draw_set_halign(fa_center);
var texwidth = string_width(text);
var texheight = string_height(text);
draw_text(view_wport[0]/2, view_hport[0]/2 - texheight/2 - 128*sc, text);

// Image
var imgwidth = sprite_get_width(image);
var imgheight = sprite_get_height(image);
draw_sprite_ext(image, 0, view_wport[0]/2+imgxoffset*sc, view_hport[0]-256*sc+imgyoffset*sc, 1, 1, 0, c_white, 1);
draw_rectangle(view_wport[0]/2+imgxoffset*sc - imgwidth/2, view_hport[0]-256*sc+imgyoffset*sc,
				view_wport[0]/2+imgxoffset*sc + imgwidth/2, view_hport[0]-256*sc+imgyoffset*sc - imgheight, true);

//Page n
draw_set_color(c_white);
draw_set_font(fnt_Nasalization24)
draw_set_halign(fa_right);
draw_text(view_wport[0]-32, view_hport[0]-32, string(slide_n+1)+"/"+string(max_slides+1))

if keyboard_check_pressed(vk_right) {
	change_slide(slide_n+1)	
}
if keyboard_check_pressed(vk_left) {
	change_slide(slide_n-1)	
}