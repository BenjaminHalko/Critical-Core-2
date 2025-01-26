/// @desc

enum BUBBLE_STATE { 
	NORMAL,
	DOUBLE_POINTS,
	WEAPON
}

// Inherit the parent event
event_inherited();

allowMerge = false;
mass = 0;
radius = 0;
absorber = noone;
absorbAmount = 0;

state = BUBBLE_STATE.NORMAL;

if (irandom(5) == 0) {
	state = BUBBLE_STATE.WEAPON;
} else if (irandom(clamp(30-global.round,15,20)-1) == 0) {
	state = BUBBLE_STATE.DOUBLE_POINTS;	
}

setRadius = function() {
	radius = sqrt(mass / pi);
	image_xscale = radius / 8;
	image_yscale = radius / 8;
}