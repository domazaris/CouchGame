
if( player_health > 0 )
{
	// Draw head
	draw_sprite_ext( sPlayerHead, 0, x + (sprite_width/2), y+ (sprite_height/2), 1, 1, 0, colour, 1);

	// Draw jetpack
	draw_sprite( sJetPack, 0, x, y );
	
	// Draw Health
	draw_healthbar(x - 1, y - 2, x - 1 + sprite_width, y - 6, player_health, c_black, c_black, c_green, 0, false, false);
}
