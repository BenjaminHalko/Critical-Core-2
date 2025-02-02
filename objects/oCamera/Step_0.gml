/// @desc Shake Camera

// Update Target Position
if (instance_exists(targetObject)) {
	targetPos.x = floor(lerp(targetObject.x, oCore.x, 0.3));
	targetPos.y = floor(lerp(targetObject.y, oCore.y, 0.3));
    
    var _targetScale = clamp(1 + ValuePercent(targetObject.radius / 2 + oCore.sprite_width / 8, 13, 50) * 1.5, 1, 1.5);
    if (global.roundIntro)
        scale = ApproachFade(scale, 1, 0.05, 0.8);
    else
        scale = ApproachFade(scale, _targetScale, 0.01, 0.9);
    
    targetPos.x = clamp(targetPos.x, room_width/2 - 104/ scale, room_width/2 + 104/ scale);
    targetPos.y = clamp(targetPos.y, room_height/2 - 104 / scale, room_height/2 + 104/ scale);
} else if (!global.inGame or oLeaderboardAPI.draw) {
    targetPos.x = room_width/2;
    targetPos.y = room_height/2;
    scale = ApproachFade(scale, 1, 0.05, 0.8);
}


viewWidth = round(RES_WIDTH * scale);
viewHeight = round(RES_HEIGHT * scale);

x += (targetPos.x - x) / 12;
y += (targetPos.y - y) / 12;

camera_set_view_size(cam, viewWidth, viewHeight);
camera_set_view_pos(cam,round(x-viewWidth/2+random_range(-shakeRemain,shakeRemain)),round(y-viewHeight/2+random_range(-shakeRemain,shakeRemain)));
shakeRemain = max(0, shakeRemain - ((1/shakeLength) * shakeMagnitude));
