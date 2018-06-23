
if( player_health > 0 )
{
	// Draw jetpack
	draw_sprite( sJetPack, 0, x, y );
	
	// Draw head
	jetpack_w = sprite_get_width(sJetPack);
	jetpack_h = sprite_get_height(sJetPack);
	draw_sprite_ext( sPlayerHead, 0, x, y + jetpack_h / 2, 1, 1, 0, colour, 1);

	// Draw Health
	draw_healthbar(x - 1, y - 2, x - 1 + jetpack_w, y - 6, player_health, c_black, c_black, c_green, 0, false, false);
}
