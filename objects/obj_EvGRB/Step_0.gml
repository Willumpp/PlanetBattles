/// @description Insert description here


// Inherit the parent event
event_inherited();

//Play the laser sound as long as its alive
/*
audio_emitter_position(audio_emitter, x, y, 0);
if sound_playing == false and state == evstate.active {
	sound_playing = true;
	audio_play_sound_on(audio_emitter, sndred_E, true, 60);
}