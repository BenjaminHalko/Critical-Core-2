/// @desc Setup

EnableLive;

event_inherited();


audio_play_sound(snFireShoot, 1, false);
radius = clamp(sqrt(max(0,oPlayer.mass) / pi), 10, 50);
ScreenShake(4, 10);

dir = point_direction(x, y, oCore.x, oCore.y);