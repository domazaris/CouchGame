var i = 0;

repeat(buttons)
{
	if( menu_index == i )
	{
		draw_set_color(c_gray);
	}
	else
	{
		draw_set_color(c_white);
	}
	
	draw_text(menu_x, menu_y + (button_h * i), button[i]);
	i++;
}