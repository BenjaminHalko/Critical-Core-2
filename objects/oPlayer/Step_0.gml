/// @desc 

if (global.gameOver) exit;

// Inherit the parent event
event_inherited();

deathDelay = max(0,deathDelay-1);

// Movement
Input();
xSpd = ApproachFade(xSpd, (keyRight - keyLeft) * 2, 1, 0.7);
ySpd = ApproachFade(ySpd, (keyDown - keyUp) * 2, 1, 0.7);

if (keyLeft or keyRight or keyUp or keyDown) {
	oCore.playerHasMoved = true;
	oGUI.moveTutorial = false;
	oGUI.alarm[1] = -1;
}

if (!global.nextRound and !global.roundIntro and oCore.playerHasMoved) {
	var _dist = point_distance(0,0,xSpd,ySpd) / 3;
	mass -= _dist + mass / 500;
	
	if (radius < 1) {
		GameOver(true);
	}
}

// Fade Values
pulse = ApproachFade(pulse, 0, 0.05, 0.7);
image_blend = merge_color(c_white, #9400DD, pulse);

// Trail
if (irandom(2 + BROWSER * 2) == 0) {
	var _dir = random(360);
	var _len = random(radius * 0.55);
	with(instance_create_depth(x+lengthdir_x(_len, _dir), y+lengthdir_y(_len,_dir), depth+1, oPlayerTrail)) {
		radius = other.radius / 3;
	}
}

// Fireball
if (shootFireball) {
	fireballChargeUp = Approach(fireballChargeUp, 1, 0.2);
	if (fireballChargeUp == 1) {
		shootFireball = false;
		mass -= mass * 0.5;
		var _fire = instance_create_depth(x, y, depth-1, oFireball);
        _fire.image_blend = #EEA612;
	}
} else {
	fireballChargeUp = Approach(fireballChargeUp, 0, 0.1);	
}

//image_blend = merge_color(image_blend, c_red, fireballChargeUp);

if (radius > outerSize)
    outerSize = radius;
outerSize = ApproachFade(outerSize, radius, 0.5, 0.8);
