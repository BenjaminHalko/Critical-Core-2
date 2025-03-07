/// @desc Merge Bubbles

if (global.gameOver) exit;

// Inherit the parent event
event_inherited();

function absorb() {
	if (state == BUBBLE_STATE.DOUBLE_POINTS) audio_play_sound(snPointBoost, 2, false);
	else audio_play_sound(snCollect, 2, false, 1, 0, 1.25 * min(1.4, (absorbAmount * 0.4 + 240) / 300 - 0.2));
	with(instance_create_layer(absorber.x,absorber.y-absorber.radius-1,"GUI",oScore)) {
		amount = round(other.absorbAmount);
		double = (other.state == BUBBLE_STATE.DOUBLE_POINTS);
	}
	if (state == BUBBLE_STATE.DOUBLE_POINTS) absorbAmount *= 3;
    if (state == BUBBLE_STATE.WEAPON) {
        with(oPlayer) {
            shootFireball = true;
        }
    }
	global.score += absorbAmount;
	absorber.pulse = 1;
	absorber.mass += mass;
}

if (!instance_exists(absorber)) {
    // Create particles
    if (state == BUBBLE_STATE.WEAPON) {
        if(irandom(4) == 0) {
            var _dist = random(radius);
            var _dir = random(360);
            with(instance_create_depth(x + lengthdir_x(_dist, _dir), y + lengthdir_y(_dist, _dir), depth - 1, oSparkle)) {
                speed = random(point_distance(other.xSpd, other.ySpd, 0, 0));
                var _dir2 = point_direction(other.xSpd, other.ySpd, 0, 0);
                direction = random_range(_dir2 - 5, _dir2 + 5);
            }
        }
    }
    
	var _bubble = instance_place(x,y,oBubble);
	if (_bubble != noone) {
		if (allowMerge and _bubble.allowMerge) {
			if (object_index == oPlayer and !instance_exists(_bubble.absorber)) {
				_bubble.absorber = id;
				_bubble.absorbAmount = round(_bubble.mass / 2);	
			}
				
			if (_bubble.object_index == oPlayer) {
				absorber = _bubble;
				absorbAmount = round(mass / 2);
			} else {
				// Calculate the distance between the centers of the two bubbles
				var distance = point_distance(x, y, _bubble.x, _bubble.y);

				// Calculate the overlap (the sum of the radii minus the distance)
				var overlap = (radius + _bubble.radius + 2) - distance;
						
				// Calculate the absorption amount
				var _absorption = min(max(overlap, 20), mass, _bubble.mass); // Absorb at most the mass of the absorbing bubble

				// Calculate the ratio of absorption for each bubble
				var _absorptionRatio = _absorption / mass;
				var _otherAbsorptionRatio = _absorption / _bubble.mass;
		
				// Calculate the one to absorb
				_absorption *= (object_index == oPlayer or (mass >= _bubble.mass and _bubble.object_index != oPlayer)) ? 1 : -1;

				// Update mass
				mass += _absorption;
				_bubble.mass -= _absorption;

				// Update speed
				if (object_index != oPlayer) {
					xSpd = lerp(xSpd, _bubble.xSpd, _absorptionRatio / 2);
					ySpd = lerp(ySpd, _bubble.ySpd, _absorptionRatio / 2);
						
					_bubble.xSpd = lerp(_bubble.xSpd, xSpd, _otherAbsorptionRatio / 2);
					_bubble.ySpd = lerp(_bubble.ySpd, ySpd, _otherAbsorptionRatio / 2);
				}
						
				if (mass < 1 and object_index != oPlayer) instance_destroy();
				if (_bubble.mass < 1) {
					if (_bubble.absorber != noone and object_index == oPlayer) {
						with(_bubble) {
							absorb();	
						}
					}
					instance_destroy(_bubble);
				}
			}
		}
	} else {
		allowMerge = true;
	}
} else {
	var _dist = point_distance(x,y,absorber.x,absorber.y);
	var _dir = point_direction(x,y,absorber.x,absorber.y);
	xSpd = lengthdir_x(5, _dir);
	ySpd = lengthdir_y(5, _dir);
	
	if _dist < 5 {
		absorb();
		instance_destroy();
	}
}

// Squish bubble
if (object_index == oBubble) {
	var _list = ds_list_create();
	instance_place_list(x,y,oWall,_list,false);
	var _inner = false;
	var _outer = false;
	for(var i = 0; i < ds_list_size(_list); i++) {
		if (_list[| i].flipped) {
			_inner = true;	
		} else {
			_outer = true;	
		}
		
		if (_inner and _outer) {
			BurstBubble(id);
		}
	}
	ds_list_destroy(_list);
}

// Set Radius
radius = ApproachFade(radius, sqrt(max(0,mass) / pi), 1, 0.7);
image_xscale = radius / 8;
image_yscale = radius / 8;

if (object_index != oPlayer and mass < 1) {
	instance_destroy();	
}