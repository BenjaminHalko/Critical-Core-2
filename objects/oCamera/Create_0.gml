/// @desc Setup Camera

cam = view_camera[0];

shakeLength = 0;
shakeMagnitude = 0;
shakeRemain = 0;

viewWidth = RES_WIDTH;
viewHeight = RES_HEIGHT;

targetObject = oPlayer;
targetPos = {
	x: room_width/2,
	y: room_height/2
};

x = targetPos.x;
y = targetPos.y;

camWidth = 256;