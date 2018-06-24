
var active = instance_number(oJetPackBrawlPlayer);
if( active <= 1)
{
	var r_w = room_width;
	var r_h = room_height;
	if( active == 0 )
	{
		draw_text(r_w/2, r_h/2, "There was no winner! Everybody loses!");
	}
	else
	{
		draw_text(r_w/2, (r_h/2) - 128, "We have a winner!");
		draw_sprite_stretched_ext(sPlayerHead, 0, r_w/2, r_h/2, 128, 128, winning_colour, 1);
	}
}
