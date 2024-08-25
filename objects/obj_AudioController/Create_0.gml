menu_songs = tag_get_asset_ids("sndMenu", asset_sound);
menulistlen = array_length(menu_songs);

menu_song = menu_songs[irandom_range(0, menulistlen-1)];

combat_songs = tag_get_asset_ids("sndCombat", asset_sound);
comblistlen = array_length(combat_songs);

combat_song = combat_songs[irandom_range(0, comblistlen-1)];

//get all sound volumes
sfxs = tag_get_asset_ids("sndSFX", asset_sound);
sfx_map = ds_map_create(); //Map of sfx : volume
sfx_emitter = audio_emitter_create();

//Add each volume to map
for (var i = 0; i < array_length(sfxs); i++) {
	sfx_map[? sfxs[i]] = audio_sound_get_gain(sfxs[i]);
}

audio_falloff_set_model(audio_falloff_linear_distance);

//Sound effects are played by individual objects
/*
function sfx_play(soundid, x, y) {
	audio_sound_gain(soundid, sfx_map[? soundid]*global.sfx_volume, 0);
	audio_play_sound_at(soundid, x, y, 0, 100, 200, 1, false, 60);
}
*/
function sfx_play(soundid, x, y) {
	//audio_emitter_position(sfx_emitter, x, y, 0);
	audio_play_sound_on(sfx_emitter, soundid, false, 60);	
}


function sfx_play_global(soundid) {
	audio_play_sound(soundid, 60, false);	
}