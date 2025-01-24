/// @desc Move towards boss

EnableLive;

if (!instance_exists(oCore)) {
	BurstBubble(id);
}

x += lengthdir_x(5, dir);
y += lengthdir_y(5, dir);

var _wall = instance_place(x, y, oWall);
if (_wall != noone) {
    if (_wall.bossWall)
        DamageCore();
	FireballCollect();
	instance_destroy();	
}