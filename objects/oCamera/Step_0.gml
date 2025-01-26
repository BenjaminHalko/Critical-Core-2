/// @desc Shake Camera

// Update Target Position
if (instance_exists(targetObject)) {
	targetPos.x = floor(lerp(targetObject.x, oCore.x, 0.35));
	targetPos.y = floor(lerp(targetObject.y, oCore.y, 0.35));
} else if (!global.inGame or oLeaderboardAPI.draw) {
    targetPos.x = room_width/2;
    targetPos.y = room_height/2;
}

x += (targetPos.x - x) / 12;
y += (targetPos.y - y) / 12;

camera_set_view_size(cam, camWidth, camWidth * (RES_HEIGHT / RES_WIDTH));
camera_set_view_pos(cam,x-viewWidth/2+random_range(-shakeRemain,shakeRemain),y-viewHeight/2+random_range(-shakeRemain,shakeRemain));
shakeRemain = max(0, shakeRemain - ((1/shakeLength) * shakeMagnitude));