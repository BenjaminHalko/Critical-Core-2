EnableLive;

if (!surface_exists(surface))
    surface = surface_create(RES_WIDTH, RES_HEIGHT);

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
    
    // Move Back
    if (point_distance(_b.x, _b.y, room_width/2, room_height/2) > room_width) {
        var _dir = random(360);
        var _dist = random(room_width/4);
        _b.x = _x + lengthdir_x(_dist, _dir);
        _b.y = _y + lengthdir_y(_dist, _dir);
        _b.alpha = 0;
    }
}

// Flash
bgFlash = Approach(bgFlash, 0, 0.2);