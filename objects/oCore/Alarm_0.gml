startX = x;
startY = y;
var _attempts = 0;
do {
    _attempts++;
    if (_attempts > 100) {
        targetX = room_width/2;
        targetY = room_height/2;
        break;
    }
	var _dist = random(180 - sprite_width / 2);
	var _dir = random(360);
	targetX = lengthdir_x(_dist, _dir) + room_width/2;
	targetY = lengthdir_y(_dist, _dir) + room_height/2;
} until(point_distance(x, y, targetX, targetY) > 80 and point_distance(x, y, targetX, targetY) < 200);
movementPercent = 0;
dashLineAmount = 0;