draw_text(32, 32, "Start to begin, b to go back");


var connected_controllers = gamepad_get_device_count();
var active_players = ds_map_size(global.players);

var screen_width = room_width;
var screen_height = room_height;

var n_positions = active_players + 1; // +1 for 0th pos on left wall
var h_offset = (screen_width - (n_positions * (player_width/2))) / n_positions; 
var v_offset = (screen_height / 2) - (player_height / 2);

// Iterate each controller
var real_cid = 0;
for( var c_id = 0; c_id < connected_controllers; c_id++ )
{
	if( ds_map_exists(global.players, c_id) )
	{
		// Draw the player with their colour
		var h_player_offset = (real_cid * h_offset) + h_offset;
		real_cid += 1;
		
		// draw players
		var c = global.p_colours[c_id]
		
		var x1 = h_player_offset; 
		var x2 = h_player_offset + player_width;
		
		var y1 = v_offset;
		var y2 = v_offset + player_width;
		
		var a_pressed = gamepad_button_check(c_id, gp_face1);
		if( a_pressed )
		{
			y1 -= player_height/2;
			y2 -= player_height/2;
		}
		
		draw_rectangle_color(x1, y1, x2, y2, c, c, c, c, false);
		
		var b_pressed = gamepad_button_check(c_id, gp_face2);
		if( b_pressed && real_cid == 1 )
		{
			room_goto(rMultiPlayerGamesMenu);
		}
	}
}