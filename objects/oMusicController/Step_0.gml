/// @desc 

if (music == noone) {
    music = audio_play_sound(mMusic, 1, true);
}

if (room == rInit)
    exit;

var _currentBeat = audio_sound_get_track_position(music) / 60 * 130;
var _tick = _currentBeat % 0.5;
global.audioTick = (_tick < lastTick);
global.audioBeat = floor((_currentBeat % 8) * 2) / 2;
lastTick = _tick;
if (lastBar > global.audioBeat) {
	wallPulseColor = make_color_hsv(random(255), 255, 255);
	wallPulseType = irandom(1);
}
lastBar = global.audioBeat;

if (global.audioTick) {
	var _type = undefined;
	switch(wallPulseType) {
		default: case 0: {
			if (global.audioBeat % 1 == 0) {
				_type = [global.audioBeat, (4 + global.audioBeat) % 8];
			}
		} break;
		case 1: {
			if (global.audioBeat % 1 == 0) {
				_type = [7-global.audioBeat, 7 - (4 + global.audioBeat) % 8];
			}
		} break;
	}
	if (!is_undefined(_type)) {
		with(oWall) {
			if (array_contains(_type, index,0,array_length(_type))) {
				beatPulse = 1;
				colorPulse = 1;
			}
		}
	}
	
	if (global.audioBeat % 1 == 0) {
        coreEffectPulse = 1;
		with(oWall) {
			beatPulse = max(beatPulse, 0.5 + 2 * (index == -1));
			colorPulse = max(colorPulse, 0.5 + 0.2 * (index == -1));
		}
		if (!global.gameOver or !instance_exists(oPlayer)) {
			with(oCore) {
				pulse = 1;
				if (!global.nextRound and !global.roundIntro and playerHasMoved) targetScale += getCoreIncrease();
			}
		}
	}
}

coreEffectPulse = ApproachFade(coreEffectPulse, 0, 0.1, 0.8);
global.coreEffectTime += 0.005 + coreEffectPulse * 0.02;