
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
