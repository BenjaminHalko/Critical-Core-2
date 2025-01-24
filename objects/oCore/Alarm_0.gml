EnableLive;

startX = x;
startY = y;
do {
	var _dist = random(180 - sprite_width / 2);
	var _dir = random(360);
	targetX = lengthdir_x(_dist, _dir) + room_width/2;
	targetY = lengthdir_y(_dist, _dir) + room_height/2;
} until(point_distance(x, y, targetX, targetY) > 100);
movementPercent = 0;
dashLineAmount = 0;