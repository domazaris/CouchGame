// Controller
c_id = -1;
vibrate_cooldown = 0;

// Default Movement
hsp = 0; // horizontal speed
vsp = 0; // vert speed
grv = 0.3; // gravity
walksp = 4; // Walk speed

// Default Colour
colour = c_white;

// Health
player_health = 100;

// Inputs		
l_stick_x_val = 0;
l_stick_y_val = 0;
r_stick_x_val = 0;
r_stick_y_val = 0;
a_pressed = 0;
b_pressed = 0;
x_pressed = 0;
y_pressed = 0;
l_bumper = 0;
r_bumper_pressed = 0;
l_trigger = 0;
r_trigger_pressed = 0;

// Sprite
sprite_index = sJetPack;

// Weapons
active_ammo = instance_create_layer(-1000, -1000, "instances", oJetPackBrawlAmmo);;
last_shot_x_value = 0;
last_shot_y_value = 0;
