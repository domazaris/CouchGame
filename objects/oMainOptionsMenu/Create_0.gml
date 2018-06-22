
// Create menu options
block_size = 32;

menu_x = block_size;
menu_y = block_size;
button_h = block_size;

fullscreen = window_get_fullscreen();
if( window_get_fullscreen() )
{
	fullscreen_string = "On";
}
else
{
	fullscreen_string = "Off";
}

button[0] = "fullscreen: " + fullscreen_string;
button[1] = "back";

buttons = array_length_1d(button);

menu_move = 0;
menu_index = 0;
last_selected = 0;
