
var min_x = 0;
var max_x = room_width;
var min_y = 0;
var max_y = room_height;

// Iterate each controller and add active players
var connected_controllers = gamepad_get_device_count();
for( var c_id = 0; c_id < connected_controllers; c_id++ )
{
	// Check gamepad is connected
	if( gamepad_is_connected( c_id ) )
	{
		// Check for pause menu
		var start_pressed = gamepad_button_check_pressed(c_id, gp_start);
		if( start_pressed )
		{
			instance_create_layer(x, y, "instances", oPauseMenu);
		}
		
		if( ds_map_exists(game_players, c_id) )
		{
			// Get player object
			var current_player = game_players[? c_id];
			
			// Deactivate unhealthy players
			if( current_player.player_health == 0 )
			{
				instance_deactivate_object(current_player);
			}
			
			// Inputs			
			current_player.l_stick_x_val = gamepad_axis_value(c_id, gp_axislh);
			current_player.l_stick_y_val = gamepad_axis_value(c_id, gp_axislv);
			current_player.r_stick_x_val = gamepad_axis_value(c_id, gp_axisrh);
			current_player.r_stick_y_val = gamepad_axis_value(c_id, gp_axisrv);
			current_player.a_pressed = gamepad_button_check_pressed(c_id, gp_face1); // a button
			current_player.b_pressed = gamepad_button_check_pressed(c_id, gp_face2); // b button
			current_player.x_pressed = gamepad_button_check_pressed(c_id, gp_face3); // x button
			current_player.y_pressed = gamepad_button_check_pressed(c_id, gp_face4); // y button
			current_player.l_bumper = gamepad_button_check(c_id, gp_shoulderl);
			current_player.r_bumper_pressed = gamepad_button_check_pressed(c_id, gp_shoulderr);
			current_player.l_trigger = gamepad_button_check(c_id, gp_shoulderlb);
			current_player.r_trigger_pressed = gamepad_button_check_pressed(c_id, gp_shoulderrb);
			
			// Set min/max players
			if(instance_exists(current_player))
			{
				var p_x = current_player.x;
				var p_y = current_player.y;
				if( p_x < max_x )
				{
					max_x = p_x + current_player.sprite_width;
				}
				if( p_x > min_x )
				{
					min_x = p_x;
				}
				if( p_y < max_y )
				{
					max_y = p_y + current_player.sprite_height;
				}
				if( p_y > min_y )
				{
					min_y = p_y;
				}
			}
		}
	}
}

// Set view
var x_ratio = window_get_width() / room_width;
var y_ratio = window_get_height() / room_height;

room_set_view_enabled(rJetPackBrawl, true);
room_set_viewport(rJetPackBrawl, 0, 1, min_x, min_y, max_x - min_x, max_y - min_y );
