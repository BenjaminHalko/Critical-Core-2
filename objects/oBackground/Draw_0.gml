EnableLive;

surface_set_target(surface);
draw_clear_alpha(c_black, 0);
camera_apply(view_camera[0]);

draw_set_color(merge_color(#00001a, #0a0a60, bgFlash));
draw_primitive_begin(pr_trianglelist);
var _scale = wallToCheck.scaleMenu + 1;
for(var i = 0; i < array_length(polygonPoints); i++) {
    var j = (i + 1) % array_length(polygonPoints);
    draw_vertex(x,y);
    draw_vertex(x+polygonPoints[i][0]*_scale-sign(polygonPoints[i][0]), y+polygonPoints[i][1]*_scale-sign(polygonPoints[i][1]));
    draw_vertex(x+polygonPoints[j][0]*_scale-sign(polygonPoints[j][0]), y+polygonPoints[j][1]*_scale-sign(polygonPoints[j][1]));
}
draw_primitive_end();

gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_inv_src_alpha, bm_dest_alpha);
for(var i = 0; i < bubbleCount; i++) {
    var _b = bubbles[i];
    var _wave = Wave(-1, 1, 2, i / bubbleCount) * 4;
    draw_sprite_ext(sBGBubbles, _b.index, round(_b.x + lengthdir_x(_wave, _b.dir + 90)), round(_b.y + lengthdir_y(_wave, _b.dir + 90)), 1, 1, 0, c_white, _b.alpha);
}
gpu_set_blendmode(bm_normal);

surface_reset_target();

draw_surface(surface, camera_get_view_x(oCamera.cam), camera_get_view_y(oCamera.cam));