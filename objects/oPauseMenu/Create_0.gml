// Setup menu
menu_x = 32;
menu_y = 32;
button_h = 32;

// Options
button[0] = "resume";
button[1] = "main menu";

buttons = array_length_1d(button);

menu_move = 0;
menu_index = 0;
last_selected = 0;

// Deactive everything
instance_deactivate_all(true);
