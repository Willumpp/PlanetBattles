//Open escape layer when pressed
menu_opened = !menu_opened;
layer_set_visible("ESC", menu_opened);

obj_AudioController.sfx_play(sndesc, x, y);