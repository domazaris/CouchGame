if( audio_is_playing(sndBackgroundEpic) )
{
	audio_stop_sound(sndBackgroundEpic);
}

if( ! audio_is_playing(sndBackgroundPiano) )
{
	audio_play_sound(sndBackgroundPiano, 1, true);
}

// Reset player colour registry
global.players = ds_map_create();

// Player details
player_height = sprite_get_height(sPlayerHead) * 4;
player_width = sprite_get_width(sPlayerHead) * 4;
