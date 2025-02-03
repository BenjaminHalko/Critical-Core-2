/// @desc 

var _shooting = false;

if (!global.gameOver and !global.nextRound and !global.roundIntro and playerHasMoved) {
	if (global.audioTick and global.audioBeat % 1 == 0) {
		shootDir += (30 + global.round * 4) * (flipShootDir ? -1 : 1);
        var _count = 0;
        with(oBubble) {
            if (state == BUBBLE_STATE.WEAPON)
                _count++;
        }
        
        if (global.audioBeat % 2 == 0) {
            timeSinceLastPurple--;
        }
        if (timeSinceLastPurple <= 0) {
            if (global.audioBeat % 2 == 0 and _count < 4)
                timeSinceLastPurple = 1;
            else
                timeSinceLastPurple = 0;
        }
        
        coreShoot();
	}
	_shooting =  true;
}

if (!global.gameOver or !instance_exists(oPlayer)) {
	pulse = Approach(pulse,0,0.1);
	scale = ApproachFade(scale,(targetScale * 208 + pulse * 10) / 208,1,0.7);
}
image_xscale = scale;
image_yscale = scale;

// Heal
if (hpWaitHeal <= 0) {
    if (global.audioTick and global.audioBeat % 1 == 0) {
        hp = min(1, hp + coreHeal());
    }
} else {
    hpWaitHeal = Approach(hpWaitHeal, 0, 1);
}
hpDraw = ApproachFade(hpDraw, hp, 0.1, 0.8);


if (_shooting) {
    if (alarm[0] <= 0 and dashLineAmount > 0.99) {
        movementPercent = Approach(movementPercent, 1, coreSpeed());
        if (movementPercent == 1) {
            alarm[0] = coreSpeedPause();	
        }
        
        var _percent = animcurve_channel_evaluate(movementCurve, movementPercent);
        x = lerp(startX, targetX, _percent);
        y = lerp(startY, targetY, _percent);
    }
} else if (global.roundIntro or global.nextRound) {
    timeSinceLastPurple = 0;
    alarm[0] = -1;
    if (dashLineAmount > 0.99 or global.roundIntro) {
        movementPercent = Approach(movementPercent, 1, global.roundIntro ? 0.05 : coreSpeed() * 2);
        
        var _percent = animcurve_channel_evaluate(movementCurve, movementPercent);
        x = lerp(startX, targetX, _percent);
        y = lerp(startY, targetY, _percent);
    }
} else {
    alarm[0] = -1;
}

if (!global.gameOver)
    dashLineAmount = ApproachFade(dashLineAmount, 1, 0.1, 0.85);	

for(var i = 0; i < array_length(walls); i++) {
	with(walls[i].instance) {
		var _scale = other.scale + 0.12;
		image_xscale = other.walls[i].scale * _scale;
		x = other.x+lerp(xstart, other.walls[i].x, _scale)-room_width/2;
		y = other.y+lerp(ystart, other.walls[i].y, _scale)-room_height/2;
	}
}
