
dy -= grav;
if( dx > 0) dx -= drag;
if( dx < 0) dx += drag;


drag /= 2 ;
if( grav < 0.5 ) grav *= 2;

y = y - (dy);
x = x - (dx);

// Wall collision
if( place_meeting(x,y, oWall) )
{
	effect_create_below(ef_explosion, bbox_left + random(sprite_width), bbox_bottom + random(sprite_height), choose(0.5, 1), merge_colour(c_red, c_yellow, random(1)));
	instance_destroy(self);
}

// Off Screen
if( x > room_width || x < 0 || y > room_height || y < 0 )
{
	instance_destroy(self);
}
