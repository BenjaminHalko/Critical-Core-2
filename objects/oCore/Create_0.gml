/// @desc 

EnableLive;

hp = 1;
hpRotation = 0;
hpWaitHeal = 0;
hpDraw = 1;

shootDir = random(360);
x = room_width/2;
y = room_height/2;

startX = x;
startY = y;
targetX = x;
targetY = y;
movementCurve = animcurve_get_channel(CoreCurves, "movement");
movementPercent = 0;


dashLineAmount = 0;

pulse = 0;
targetScale = 0.1;
scale = 0;

delay = 0;
playerHasMoved = false;
flipShootDir = false;

walls = [];
with(oWall) {
	array_push(other.walls, {
		x: x,
		y: y,
		dir: image_angle,
		scale: image_xscale
	});
}

for(var i = 0; i < array_length(walls); i++) {
	var _wall = instance_create_depth(x,y,depth-1,oWall);
	with(_wall) {
		image_angle = other.walls[i].dir;
		image_xscale = 0;
		flipped = true;
		index = -1;
        bossWall = true;
	}
	walls[i].instance = _wall;
}

polygonPoints = [
	[-24, -104],
	[24, -104],
	[104, -24],
	[104, 24],
	[24, 104],
	[-24, 104],
	[-104, 24],
	[-104, -24]
]


bgFlash = 0;
bgLayer = layer_background_get_id("Background");