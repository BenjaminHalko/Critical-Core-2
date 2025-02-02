surface = surface_create(RES_WIDTH, RES_HEIGHT);
wallToCheck = oWall.id;
bgFlash = 0;
x = room_width/2;
y = room_height/2;

polygonPoints = [
    [-24, -104],
    [24, -104],
    [104, -24],
    [104, 24],
    [24, 104],
    [-24, 104],
    [-104, 24],
    [-104, -24]
];

bubbleCount = 300;
bubbles = [];
bubbleFrameCount = sprite_get_number(sBGBubbles);

repeat(bubbleCount) {
    var _dir = random(360);
    var _dist = random(room_width);
    array_push(bubbles, {
        index: irandom(bubbleFrameCount - 1),
        x: room_width/2 + lengthdir_x(_dist, _dir),
        y: room_height/2 + lengthdir_y(_dist, _dir),
        dir: _dir,
        spd: 0,
        alpha: 0,
        purple: 0
    });
}
