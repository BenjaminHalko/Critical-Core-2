/// @desc 

if (global.gameOver) exit;

// Inherit the parent event
event_inherited();

image_angle -= 10;

if (!place_meeting(x,y,oCore)) {
    var _bubble = instance_place(x,y,oBubble);
    if (_bubble != noone) {
        if (_bubble.object_index == oBubble) {
            if (_bubble.state == BUBBLE_STATE.WEAPON) {
                var _count = 0;
                with(oBubble) {
                    if (state == BUBBLE_STATE.WEAPON)
                        _count++;
                }
                if (_count <= 1) {
                    oCore.timeSinceLastPurple = infinity;
                }
            }
            BurstBubble(_bubble);
        } else if (_bubble.object_index == oPlayer) {
            audio_play_sound(snPointLoss, 2, false)
            with(instance_create_layer(_bubble.x,_bubble.y-_bubble.radius-1,"GUI",oScore)) {
                amount = 500;
                negative = true;
            }
            global.score -= 500;
            _bubble.mass -= 200;
        }
        instance_destroy();
    }
}
