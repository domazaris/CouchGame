
// Round movement vals
if(l_stick_x_val < 0.1 && l_stick_x_val > -0.1)
{
	l_stick_x_val = 0;
}

// Check jump
if( ( place_meeting(x, y + 1, oWall) || place_meeting(x, y+1, oBreakableWall)) && a_pressed )
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
if( place_meeting(x + hsp, y, oWall) || place_meeting(x + hsp, y, oBreakableWall) )
{
	while(!place_meeting(x + sign(hsp), y, oWall) && !place_meeting(x + sign(hsp), y, oBreakableWall))
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
if( place_meeting(x, y + vsp, oWall) || place_meeting(x, y + vsp, oBreakableWall) )
{
	while(!place_meeting(x, y + sign(vsp), oWall) && !place_meeting(x, y + sign(vsp), oBreakableWall))
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
	active_ammo = instance_create_layer(x + (sprite_width/2), y + (sprite_height/2), "instances", oJetPackBrawlAmmo);
	active_ammo.player = self;
	active_ammo.colour = colour;
	
	if( r_stick_x_val > 0.5 || r_stick_x_val < -0.5 || r_stick_y_val > 0.5 || r_stick_y_val < -0.5 )
	{
		last_shot_x_value = -r_stick_x_val;
		last_shot_y_value = -r_stick_y_val;
	}
	
	active_ammo.dx = last_shot_x_value * active_ammo.x_magnifier;
	active_ammo.dy = last_shot_y_value * active_ammo.y_magnifier;
}

// The player is hit by a bullet
if( place_meeting(x,y, oJetPackBrawlAmmo) )
{
	// No self damage
	var laser_ball = instance_place(x, y, oJetPackBrawlAmmo);
	if( laser_ball.player != self )
	{
		audio_play_sound(sndAmmoHit, 2, 0);
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
