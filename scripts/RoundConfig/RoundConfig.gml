function getCoreStart() {
    return 0.1 + 0.004 * global.round;
}

function getCoreIncrease() {
    return 0.01 + 0.0025 * global.round + 0.04 * oCore.hpHit;
}

function coreHPDamage() {
    return (1 / (3.5 + global.round * 0.75));	
}

function coreHeal() {
    return 0.015;	
}

function coreWaitToHeal() {
    return 180;	
}

function coreTotalDamage() {
    if (hp == 0)
        return 1;
    return (1-hp) * targetScale * 0.6;
}

function coreSpeed() {
	return 0.008 - oCore.targetScale * 0.003;	
}

function coreSpeedPause() {
	return 40;
}

function coreShoot() {
    var _shoot = function(_shootDir, _obj, _size = 0) {
        var _layer = _obj == oSpike ? "Spikes" : "Bubbles";
        with(instance_create_layer(x+lengthdir_x(5,_shootDir),y+lengthdir_y(5,_shootDir),_layer,_obj)) {
            var _dir = _shootDir + random_range(-5,5);
            var _spd = random_range(1, 1.5);
            if (_obj == oSpike) _spd = random_range(0.4, 0.8) + 0.01 * global.round;
            xSpd = lengthdir_x(_spd, _dir);
            ySpd = lengthdir_y(_spd, _dir);
        
            if (object_index == oBubble) {
                mass = _size;
                if (state == BUBBLE_STATE.WEAPON) {
                    mass += 10;
                }
                //setRadius();
            }
        }
    }
    
    switch(global.round) {
        case 1: {
            _shoot(shootDir, oBubble, random_range(100, 150));
            _shoot(shootDir+180, oBubble, random_range(100, 150));
        } break;
        case 2: {
            _shoot(shootDir, oBubble, random_range(100, 120));
            _shoot(shootDir+120, oBubble, random_range(100, 120));
            _shoot(shootDir+240, oBubble, random_range(100, 120));
        } break;
        case 3: {
            _shoot(shootDir, oBubble, random_range(90, 110));
            _shoot(shootDir+180, choose(oSpike, oBubble));
            _shoot(shootDir+90, oBubble, random_range(100, 150));
            _shoot(shootDir+270, oBubble, random_range(100, 150));
        } break;
        case 4: {
            _shoot(shootDir, oBubble, random_range(220, 250));
            _shoot(shootDir+180, oBubble, random_range(220, 250));
        } break;
        default: {
            if (global.round % 3 == 0) {
                _shoot(shootDir, oBubble, random_range(60, 130));
                _shoot(shootDir+180, choose(oBubble, oSpike), random_range(100, 130));
                _shoot(shootDir+90, oBubble, random_range(60, 130));
                _shoot(shootDir+270, oBubble, random_range(60, 130));
            } else if (global.round % 3 == 1) {
                _shoot(shootDir, irandom(5) == 0 ? oSpike : oBubble, random_range(200, 220));
                _shoot(shootDir+180, irandom(5) == 0 ? oSpike : oBubble, random_range(200, 220));
            } else {
                _shoot(shootDir, irandom(4) == 0 ? oSpike : oBubble, random_range(130, 180));
                _shoot(shootDir+120, oBubble, random_range(100, 140));
                _shoot(shootDir+240, irandom(4) == 0 ? oSpike : oBubble, random_range(150, 180));
            }			
        } break;
    }
    
    if (global.round >= 2) {
        if (global.audioBeat % 2 == 0) {
            _shoot(point_direction(x,y,oPlayer.x,oPlayer.y),oSpike);
        }
    }
}

