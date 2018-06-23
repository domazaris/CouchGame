
// Get the connected controller count
var connected_controllers = gamepad_get_device_count();

// Iterate each controller
for( var c_id = 0; c_id < connected_controllers; c_id++ )
{
	// Check gamepad is connected
	if( gamepad_is_connected( c_id ) )
	{
		// get the up/down values
		var c_up = gamepad_button_check_pressed(c_id, gp_padu);
		var c_down = gamepad_button_check_pressed(c_id, gp_padd);
		
		// Move the menu index
		menu_move = c_down - c_up;
		menu_index += menu_move;

		// Loop the menu at top & bottom
		if(menu_index < 0)
		{
			// Top - goto bottom
			menu_index = buttons - 1;
		}
		else if(menu_index > buttons - 1)
		{
			// Bottom - goto top
			menu_index = 0;
		}
		
		// Store the menu index
		last_selected = menu_index;
		
		// If a is pressed, select that item
		var a_pressed = gamepad_button_check_pressed(c_id, gp_face1);
		if( a_pressed )
		{
			switch(menu_index)
			{
				case 0:
				{
					room_goto(rJetPackBrawlRegister);
					break;
				}
				case 1:
				{
					room_goto(rMainMenu);
					break;
				}
				default:
				{
					show_error("ERROR, invalid menu option", true);
					break;
				}
			}
		}
		var b_pressed = gamepad_button_check_pressed(c_id, gp_face2);
		if( b_pressed )
		{
			room_goto(rMainMenu);
		}
		break;
	}
}
