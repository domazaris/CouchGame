var i = 0;


var largest_y = 0;
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
	
	largest_y =  menu_y + (button_h * i);
	draw_text(menu_x, largest_y, button[i]);
	i++;
}

draw_set_color(c_yellow);
draw_text(menu_x, largest_y + (2*button_h), "Music:         https://www.bensound.com");
draw_text(menu_x, largest_y + (3*button_h), "Sound effects: SoundBible.com");