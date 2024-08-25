
//Menu
if play_menu == true and audio_is_playing(menu_song) == false {
	menu_song = menu_songs[irandom_range(0, menulistlen-1)];
	audio_play_sound(menu_song, 50, false);
	audio_sound_gain(menu_song, global.music_volume/2, 0);
}

if play_combat == true and audio_is_playing(combat_song) == false {
	combat_song = combat_songs[irandom_range(0, menulistlen-1)];
	audio_play_sound(combat_song, 50, false);
	audio_sound_gain(combat_song, global.music_volume/2, 0);

}

/*
var xpos = camera_get_view_x(view_camera[0]) + view_wport[0]/2;
var ypos = camera_get_view_y(view_camera[0]) + view_hport[0]/2;
audio_listener_position(xpos+500, ypos, 0);
*/