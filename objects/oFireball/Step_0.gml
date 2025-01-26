/// @desc Move towards boss

if (!instance_exists(oCore)) {
	BurstBubble(id);
}

x += lengthdir_x(6, dir);
y += lengthdir_y(6, dir);

var _wall = instance_place(x, y, oWall);
if (_wall != noone) {
    if (_wall.bossWall)
        DamageCore();
	FireballCollect();
	instance_destroy();	
}

var _wave = Wave(-1, 1, 1, 0) * sprite_width / 2;
with(instance_create_depth(x + lengthdir_x(_wave, dir + 90), y + lengthdir_y(_wave, dir + 90), depth - 1, oPlayerTrail)) {
    radius = 5;
    speed = random(2);
    direction = random(360);
    image_blend = choose(#EE8213, #EEA612);
    spd = random_range(0.02,0.05);
}