/// @desc 

hp = 1;
hpRotation = 0;
hpWaitHeal = 0;
hpDraw = 1;
hpHit = 0;

shootDir = random(360);
x = room_width/2;
y = room_height/2;

startX = x;
startY = y;
targetX = x;
targetY = y;
movementCurve = animcurve_get_channel(CoreCurves, "movement");
movementPercent = 0;

timeSinceLastPurple = 0;


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
		x: xstart,
		y: ystart,
		dir: image_angle,
		scale: xscaleStart
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

uTime = shader_get_uniform(shCore, "iTime");
uResolution = shader_get_uniform(shCore, "iResolution");
uIntensity = shader_get_uniform(shCore, "intensity");