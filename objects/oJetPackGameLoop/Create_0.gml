// Music

if( audio_is_playing(sndBackgroundPiano) )
{
	audio_stop_sound(sndBackgroundPiano);
}

if( ! audio_is_playing(sndBackgroundEpic) )
{
	audio_play_sound(sndBackgroundEpic, 1, true);
}


// Starting x
player_x[0] = 768;
player_x[1] = 768 + (32 * 1);
player_x[2] = 768 + (32 * 2);
player_x[3] = 768 + (32 * 3);
player_x[4] = 768 + (32 * 4);
player_x[5] = 768 + (32 * 5);
player_x[6] = 768 + (32 * 6);
player_x[7] = 768 + (32 * 7);

// Starting y
player_y[0] = 832;
player_y[1] = 832;
player_y[2] = 832;
player_y[3] = 832;
player_y[4] = 832;
player_y[5] = 832;
player_y[6] = 832;
player_y[7] = 832;

//Enable the use of views
// TODO
view_enabled = false;

////Make view 0 visible
view_set_visible(0, true);

// Min cam vals
min_x_cam = 720;
min_y_cam = 480;

//Set the port bounds of view 0 to 640x480
view_set_wport(0, min_x_cam);
view_set_hport(0, min_y_cam);

// Create cam
camera = camera_create_view(0, 0, 100, 100, 0, -1, -1, -1, 32, 32);
view_set_camera(0, camera);

// Players
game_players = ds_map_create();

// Set players x and y
var connected_controllers = gamepad_get_device_count();

// Iterate each controller and add active players
for( var c_id = 0; c_id < connected_controllers; c_id++ )
{
	// Check gamepad is connected
	if( gamepad_is_connected( c_id ) )
	{
		if( ds_map_exists(global.players, c_id) )
		{
			var new_player = instance_create_layer( player_x[c_id], player_y[c_id], "instances", oJetPackBrawlPlayer);
			new_player.colour = global.players[? c_id];
			new_player.c_id = c_id;
			ds_map_add(game_players, c_id, new_player);
		}
	}
}

winning_colour = -1;
win_music_played = false;
