
if( audio_is_playing(sndBackgroundEpic) )
{
	audio_stop_sound(sndBackgroundEpic);
}

if( ! audio_is_playing(sndBackgroundPiano) )
{
	audio_play_sound(sndBackgroundPiano, 1, true);
}


// Create menu options
block_size = 32;

menu_x = block_size;
menu_y = block_size;
button_h = block_size;


button[0] = "jetpack brawl";
button[1] = "back";

buttons = array_length_1d(button);

menu_move = 0;
menu_index = 0;
last_selected = 0;
