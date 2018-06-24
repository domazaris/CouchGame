
// Round movement vals
if(l_stick_x_val < 0.1 && l_stick_x_val > -0.1)
{
	l_stick_x_val = 0;
}

// Check jump
if( place_meeting(x, y + 1, oWall) && a_pressed )
{
	vsp = -7;
	effect_create_below(ef_smoke, bbox_left + random(sprite_width), bbox_bottom + random(sprite_height), choose(0, 1), merge_colour(c_red, c_yellow, random(1)));
}

// Jetpack
if( l_trigger )
{
	if( vsp > -4 )
	{
		vsp -= 0.5;
	}
	l_stick_x_val *= 1.5;
	effect_create_above(ef_smoke, bbox_left + random(sprite_width), bbox_bottom + random(sprite_height), choose(0.1, 0.5), merge_colour(c_red, c_yellow, random(1)));
}

// Set h movement speed
hsp = l_stick_x_val * walksp;

// Gravity
if( l_bumper && ! l_trigger )
{
	// Hovering
	vsp = 0.05;
	hsp *= 0.5;
	effect_create_below(ef_smoke, bbox_left + random(sprite_width), bbox_bottom + random(sprite_height), choose(0.1, 0.5), merge_colour(c_red, c_yellow, random(1)));
}
else
{
	// Gravity
	vsp = vsp + grv;
}

// Horizontal Collision
var w_diff = sprite_get_width(sWall);
var h_diff = sprite_get_height(sWall);
if( place_meeting(x + hsp, y, oWall) )
{
	while(!place_meeting(x + sign(hsp), y, oWall))
	{
		x = x + sign(hsp);
	}
	hsp = 0;
}
else
{
	x = x + hsp;
}

// Vertical collision
if( place_meeting(x, y + vsp, oWall) )
{
	while(!place_meeting(x, y + sign(vsp), oWall))
	{
		y = y + sign(vsp);
	}
	vsp = 0;
}
else
{
	y = y + vsp;
}

// Shooty shooty
if(r_trigger_pressed && !instance_exists(active_ammo))
{
	active_ammo = instance_create_layer(x + (sprite_width/2), y, "instances", oJetPackBrawlAmmo);
	active_ammo.player = self;
	active_ammo.colour = colour;
	active_ammo.dy = (-r_stick_y_val) * active_ammo.magnifier;
	active_ammo.dx = (-r_stick_x_val) * active_ammo.magnifier;
}

// Ouchy ouchy
if( place_meeting(x,y, oJetPackBrawlAmmo) )
{
	// No self damage
	var laser_ball = instance_place(x, y, oJetPackBrawlAmmo);
	if( laser_ball.player != self )
	{
		vibrate_cooldown = 1;
		effect_create_below(ef_explosion, bbox_left + random(sprite_width), bbox_bottom + random(sprite_height), choose(0.5, 1), merge_colour(c_red, c_yellow, random(1)));
		// Check contact with laser balls
		if( player_health > 0 )
		{
			player_health -= 5;
		}
		else if( player_health <= 0 )
		{
			player_health = 100;
		}
	
		// Destroy the laser ball
		with (laser_ball)
		{
			effect_create_below(ef_explosion, bbox_left + random(sprite_width), bbox_bottom + random(sprite_height), choose(0.5, 1), merge_colour(c_red, c_yellow, random(1)));
			instance_destroy();
		}
	}
}

gamepad_set_vibration(c_id, vibrate_cooldown, vibrate_cooldown);

if( vibrate_cooldown > 0 )
{
	vibrate_cooldown -= 0.1;	
}
