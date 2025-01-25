/// @desc 

EnableLive;

beatPulse = ApproachFade(beatPulse, 0, 0.05, 0.7);
colorPulse = ApproachFade(colorPulse, 0, 0.02, 0.7);
image_blend = merge_color(c_white, oMusicController.wallPulseColor, colorPulse);
if (instance_exists(oCore) and bossWall) {
    image_blend = merge_color(image_blend, oMusicController.wallPulseColor, oCore.hpWaitHeal / coreWaitToHeal());
}

if (!bossWall) {
    scaleMenu = ApproachFade(scaleMenu, !instance_exists(oMenu) and !oLeaderboardAPI.draw, 0.04, 0.8);
    var _scale = lerp(0.5, 1, scaleMenu);
    image_xscale = xscaleStart * _scale;
    x = lerp(room_width/2, xstart, _scale);
    y = lerp(room_height/2, ystart, _scale);
}
