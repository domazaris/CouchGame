
var x_min = -1;
var x_max = -1;
var y_min = -1;
var y_max = -1;

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
				gamepad_set_vibration(c_id, 0, 0);
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
				if( x_min < 0 || x_min < p_x ) x_max = p_x;
				if( x_max < 0 || x_max + current_player.sprite_width > p_x ) x_min = p_x + current_player.sprite_width;
				if( y_min < 0 || y_min < p_y ) y_max = p_y;
				if( y_max < 0 || y_max + current_player.sprite_height > p_y ) y_min = p_y + current_player.sprite_height;
			}
		}
	}
}

if( x_min < 0 ) x_min = 0;
if( x_max < 0 ) x_max = room_width;
if( y_min < 0 ) y_min = 0;
if( y_max < 0 ) y_max = room_height;

show_debug_message(string(x_min) + " " + string(x_max));
if( x_max - x_min < min_x_cam )
{
	var difference = (min_x_cam - (x_max - x_min)) / 2;
	x_min -= difference;
	x_max += difference;
}
else
{
	x_min -= 128;
	x_max += 128;
}

if( y_max - y_min < min_y_cam )
{
	var difference = (min_y_cam - (y_max - y_min)) / 2;
	y_min -= difference;
	y_max += difference;
}
else
{
	y_min -= 72;
	y_max += 72;
}

// Set camera
//camera_set_view_pos(view_camera[0], x_min, y_min);
//show_debug_message(string(x_max - x_min));
//camera_set_view_size(view_camera[0], x_max-x_min,  y_max-y_min);
//camera_set_view_speed(view_camera[0], -1, -1);
