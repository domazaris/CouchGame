
var connected_controllers = gamepad_get_device_count();
for( var c_id = 0; c_id < connected_controllers; c_id++ )
{
	if( gamepad_is_connected( c_id ) )
	{
		var c_up = gamepad_button_check_pressed(c_id, gp_padu);
		var c_down = gamepad_button_check_pressed(c_id, gp_padd);
		
		menu_move = c_down - c_up;
		menu_index += menu_move;

		if(menu_index < 0)
		{
			menu_index = buttons - 1;
		}
		else if(menu_index > buttons - 1)
		{
			menu_index = 0;
		}
		
		last_selected = menu_index;
		
		var start_pressed = gamepad_button_check_pressed(c_id, gp_start);
		if( start_pressed )
		{
			instance_destroy(self);
		}
		
		var a_pressed = gamepad_button_check_pressed(c_id, gp_face1);
		if( a_pressed )
		{
			switch(menu_index)
			{
				case 0:
				{
					instance_destroy(self);
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
	}
}
