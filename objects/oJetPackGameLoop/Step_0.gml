// Cmaera counts
x_total = 0;
x_count = 0;
y_total = 0;
y_count = 0;

var connected_controllers = gamepad_get_device_count();
var game_over = instance_number(oJetPackBrawlPlayer) <= 1;
if( game_over )
{
	camera_set_view_pos(view_camera[0], 0, 0);
	camera_set_view_size(view_camera[0], room_width, room_height);
	
	if( audio_is_playing(sndBackgroundEpic) )
	{
		audio_stop_sound(sndBackgroundEpic);
	}

	if( ! audio_is_playing(sndShandies) && ! win_music_played )
	{
		win_music_played = true;
		audio_play_sound(sndShandies, 2, false);
	}

	
	for( var c_id = 0; c_id < connected_controllers; c_id++ )
	{
		// Check gamepad is connected
		if( gamepad_is_connected( c_id ) )
		{
			if( ds_map_exists(game_players, c_id) )
			{
				var candidate = game_players[? c_id];
				if( candidate.player_health > 0 )
				{
					winning_colour = candidate.colour;
				}
				
				var start_pressed = gamepad_button_check_pressed(c_id, gp_start);
				if( start_pressed )
				{
					room_goto(rJetPackBrawlRegister);
				}
			}
		}
	}
}

// Iterate each controller and add active players
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
				x_total += current_player.x; x_count += 1;
				y_total += current_player.y; y_count += 1;
			}
		}
	}
}

if( x_count > 0 && y_count > 0 && !game_over )
{
	var x_ave = (x_total / x_count);
	var y_ave = (y_total / y_count);

	var x_cam = (x_ave - ( min_x_cam / 2));
	var y_cam = (y_ave - ( min_y_cam / 2));
	var x_size = min_x_cam;
	var y_size = min_y_cam;

	var futhest_player = instance_furthest(x_ave, y_ave, oJetPackBrawlPlayer);
	while( futhest_player.x > x_cam + x_size || futhest_player.y > y_cam + y_size || futhest_player.x < x_cam || futhest_player.y < y_cam )
	{
		// 16:9 ratio
		var x_rat = 16 / 2;
		var y_rat = 9 / 2;
		x_cam -= x_rat/2; x_size += x_rat;
		y_cam -= y_rat/2; y_size += y_rat;
	}

	var mul = 50;
	var x_buf = 16 * mul;
	var y_buf = 9 * mul;
	
	x_cam -= x_buf/2;
	y_cam -= y_buf/2;
	x_size += x_buf;
	y_size += y_buf;
	

	// Set camera
	camera_set_view_pos(view_camera[0], x_cam, y_cam);
	camera_set_view_size(view_camera[0], x_size, y_size );
	//camera_set_view_speed(view_camera[0], -1, -1);
}
