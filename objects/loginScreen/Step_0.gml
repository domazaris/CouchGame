// Get the connected controller count
var connected_controllers = gamepad_get_device_count();

// Iterate each controller
for( var c_id = 0; c_id < connected_controllers; c_id++ )
{
	// Check gamepad is connected
	if( gamepad_is_connected( c_id ) )
	{
		if( ! ds_map_exists(global.players, c_id) )
		{
			// Add colour to the map
			ds_map_add(global.players, c_id,  global.p_colours[c_id]);
		}
		
		// if start is pressed
		var start_game = gamepad_button_check_pressed(c_id, gp_start);
		if( start_game )
		{
			room_goto(rJetPackBrawl);
		}
	}
	else
	{
		if( ds_map_exists(global.players, c_id) )
		{
			ds_map_delete(global.players, c_id);
		}
	}
}