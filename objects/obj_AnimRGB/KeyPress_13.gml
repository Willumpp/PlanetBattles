var _sequence = Sequence1;
sequence_get(_sequence).tracks[0].tracks[0].keyframes[0].channels[1].value = room_width/480; //width
sequence_get(_sequence).tracks[0].tracks[0].keyframes[0].channels[0].value = room_height/270; //height
layer_sequence_create("IntroSequence", 0, 0, _sequence);


//480x270