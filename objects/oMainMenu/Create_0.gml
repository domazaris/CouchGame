// Default to fullscreen
window_set_fullscreen(true);

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


button[0] = "multiplayer";
button[1] = "options";
button[2] = "exit";

buttons = array_length_1d(button);

menu_move = 0;
menu_index = 0;
last_selected = 0;


// player colours
players = ds_map_create();
global.p_colours[0] = c_red;
global.p_colours[1] = c_green;
global.p_colours[2] = c_yellow;
global.p_colours[3] = c_blue;
global.p_colours[4] = c_fuchsia;
global.p_colours[5] = c_orange;
global.p_colours[6] = c_purple;
global.p_colours[7] = c_silver;
