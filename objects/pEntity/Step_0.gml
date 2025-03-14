/// @desc 

// Collide with wall
if (collide) {
	var _wall = instance_place(x+xSpd,y+ySpd,oWall);
	if (_wall != noone) {
		var _dir = point_direction(0,0,xSpd,ySpd);
        var _angleDifference = angle_difference(_dir, _wall.image_angle+90+_wall.flipped*180);
        if (_wall.bossWall and object_index != oPlayer) {
            var _oneX = lengthdir_x(1, _dir);
            var _oneY = lengthdir_y(1, _dir);
            
            while(!place_meeting(x,y,oWall)) {
                x += _oneX;	
                y += _oneY;
            }
        }
		
		if (_angleDifference <= 90) { 
			if (object_index != oPlayer) {
                var _len = point_distance(0,0,xSpd,ySpd);
                var _wallAngle = _dir - clamp(_angleDifference, -85, 85) - _wall.flipped*180 - 90;
                if (_wallAngle < 0)
                    _wallAngle += 360;
                else if (_wallAngle >= 360)
                    _wallAngle -= 360;
                _dir = 2 * _wallAngle - _dir;
                
                xSpd = lengthdir_x(_len, _dir);
                ySpd = lengthdir_y(_len, _dir);
			} else {
				var _oneX = lengthdir_x(1, _dir);
				var _oneY = lengthdir_y(1, _dir);
				while(!place_meeting(x,y,oWall)) {
					x += _oneX;	
					y += _oneY;
				}
				
				xSpd = 0;
				ySpd = 0;
			}
		}
		
		if (object_index == oPlayer and oCore.playerHasMoved) {
			if (!_wall.flipped or deathDelay <= 0) { 
				GameOver();
			}
		}
	} else if (place_meeting(x, y, oCore) and object_index != oPlayer) {
        var _dir = point_direction(oCore.x, oCore.y, x, y);
        var _len = point_distance(0,0,xSpd,ySpd);
        xSpd = lengthdir_x(_len, _dir);
        ySpd = lengthdir_y(_len, _dir);
    }
} else if (!place_meeting(x,y,oCore)) {
	collide = true;
}

// Move
if (collide) {
    spdMult = ApproachFade(spdMult, 0, 0.1, 0.8);
}
x += xSpd * (1 + spdMult * oCore.scale);
y += ySpd * (1 + spdMult * oCore.scale);