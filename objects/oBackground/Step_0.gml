for(var i = 0; i < bubbleCount; i++) {
    var _b = bubbles[i];
    
    var _x = room_width/2;
    var _y = room_height/2;
    var _nearCore = false;
    
    if (instance_exists(oCore)) {
        _x = oCore.x;
        _y = oCore.y;
        
        if (point_distance(_b.x, _b.y, _x, _y) < oCore.sprite_width / 2 + 20) {
            _nearCore = true;
        }
    }
    
    _b.dir = point_direction(_x, _y, _b.x, _b.y);
    
    _b.x += lengthdir_x(_b.spd, _b.dir);
    _b.y += lengthdir_y(_b.spd, _b.dir);
    _b.spd = ApproachFade(_b.spd, _nearCore ? 1 : 0.15, 0.1, 0.8);
    _b.alpha = ApproachFade(_b.alpha, 0.5, 0.05, 0.8);
    
    var _amount = 0;
    var _purpleDist = 80;
    with (oBubble) {
        if (state != BUBBLE_STATE.WEAPON)
            continue;
        var _dist = point_distance(_b.x, _b.y, x, y);
        var _percent = clamp(1 - (point_distance(_b.x, _b.y, x, y) - radius) / _purpleDist, 0, 1);
        _amount = max(_amount, _percent);
        if (_percent > 0) {
            var _dir = point_direction(x, y, _b.x, _b.y);
            _dir += 2 * (1 - cos(_percent * pi / 2));
            _b.x = x + lengthdir_x(_dist, _dir);
            _b.y = y + lengthdir_y(_dist, _dir);
        }
    }
    
    _b.purple = ApproachFade(_b.purple, _amount, 0.05, 0.8);
    
    // Move Back
    if (point_distance(_b.x, _b.y, room_width/2, room_height/2) > room_width) {
        var _dir = random(360);
        var _dist = random(room_width/4);
        _b.x = _x + lengthdir_x(_dist, _dir);
        _b.y = _y + lengthdir_y(_dist, _dir);
        _b.alpha = 0;
        _b.purple = 0;
    }
}

// Flash
bgFlash = Approach(bgFlash, 0, 0.2);