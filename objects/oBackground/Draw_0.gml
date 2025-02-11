if (!surface_exists(surface)) {
    surface = surface_create(oCamera.viewWidth, oCamera.viewHeight);
} else if (surface_get_width(surface) != oCamera.viewWidth) {
    surface_resize(surface, oCamera.viewWidth, oCamera.viewHeight);
}

surface_set_target(surface);
draw_clear_alpha(c_black, 0);

var _x = oCamera.x - oCamera.viewWidth / 2;
var _y = oCamera.y - oCamera.viewHeight / 2;

draw_set_color(merge_color(#00001a, #0a0a60, bgFlash));
draw_primitive_begin(pr_trianglelist);
var _scale = wallToCheck.scaleMenu + 1;
for(var i = 0; i < array_length(polygonPoints); i++) {
    var j = (i + 1) % array_length(polygonPoints);
    draw_vertex(x-_x,y-_y);
    draw_vertex(x-_x+polygonPoints[i][0]*_scale-sign(polygonPoints[i][0]), y-_y+polygonPoints[i][1]*_scale-sign(polygonPoints[i][1]));
    draw_vertex(x-_x+polygonPoints[j][0]*_scale-sign(polygonPoints[j][0]), y-_y+polygonPoints[j][1]*_scale-sign(polygonPoints[j][1]));
}
draw_primitive_end();

gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_inv_src_alpha, bm_dest_alpha);
for(var i = 0; i < bubbleCount; i++) {
    var _b = bubbles[i];
    var _wave = Wave(-1, 1, 2, i / bubbleCount) * 4;
    var _bubbleScale = oCamera.viewWidth / RES_WIDTH;
    draw_sprite_ext(sBGBubbles, _b.index, round((_b.x-_x + lengthdir_x(_wave, _b.dir + 90)) / _bubbleScale) * _bubbleScale , round((_b.y-_y + lengthdir_y(_wave, _b.dir + 90)) / _bubbleScale) * _bubbleScale, _bubbleScale, _bubbleScale, 0, merge_color(#4C4C5A, c_fuchsia, _b.purple), _b.alpha);
}
gpu_set_blendmode(bm_normal);

surface_reset_target();

draw_surface(surface, round(camera_get_view_x(oCamera.cam)), round(camera_get_view_y(oCamera.cam)));