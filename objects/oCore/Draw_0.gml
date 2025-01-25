/// @desc 

EnableLive;

// Draw Dash Line
if (dashLineAmount > 0 and movementPercent != 1) {
	var _dist = point_distance(x, y, targetX, targetY) * dashLineAmount;
	var _dir =  point_direction(x, y, targetX, targetY);
	
	draw_sprite_ext(sCoreTargetLine, 1, x + lengthdir_x(_dist, _dir), y + lengthdir_y(_dist, _dir), (_dist) / 5, 1, _dir-180, c_white, 1);
	//draw_sprite(sCoreTargetLine, 0, x + lengthdir_x(_dist, _dir)-3, y + lengthdir_y(_dist, _dir));
}

shader_set(shCore);
shader_set_uniform_f(uTime, -global.coreEffectTime);
shader_set_uniform_f(uResolution, RES_WIDTH/2, RES_HEIGHT/2);
shader_set_uniform_f(uIntensity, 0.7);

if (hpDraw != 1) {
    draw_set_color(c_white);
    draw_primitive_begin(pr_trianglelist);
    var _scale = scale;
    for(var i = 0; i < array_length(polygonPoints); i++) {
        var j = (i + 1) % array_length(polygonPoints);
        draw_vertex_texture(x,y,x / RES_WIDTH,y / RES_HEIGHT);
        draw_vertex_texture(x+polygonPoints[i][0]*_scale-sign(polygonPoints[i][0]), y+polygonPoints[i][1]*_scale-sign(polygonPoints[i][1]), (x+polygonPoints[i][0]*_scale-sign(polygonPoints[i][0]))/RES_WIDTH, (y+polygonPoints[i][1]*_scale-sign(polygonPoints[i][1])) / RES_HEIGHT);
        draw_vertex_texture(x+polygonPoints[j][0]*_scale-sign(polygonPoints[j][0]), y+polygonPoints[j][1]*_scale-sign(polygonPoints[j][1]), (x+polygonPoints[j][0]*_scale-sign(polygonPoints[j][0]))/RES_WIDTH, (y+polygonPoints[j][1]*_scale-sign(polygonPoints[j][1])) / RES_HEIGHT);
    }
    draw_primitive_end();
}

if (hpDraw > 0.05) {
	shader_set_uniform_f(uIntensity, 0.8);
    draw_set_color(merge_color(#FF005E, c_red, pulse));
    draw_primitive_begin(pr_trianglelist);
    var _scale = scale * hpDraw;
    for(var i = 0; i < array_length(polygonPoints); i++) {
        var j = (i + 1) % array_length(polygonPoints);
        draw_vertex_texture(x,y,x / RES_WIDTH,y / RES_HEIGHT);
        draw_vertex_texture(x+polygonPoints[i][0]*_scale-sign(polygonPoints[i][0]), y+polygonPoints[i][1]*_scale-sign(polygonPoints[i][1]), (x+polygonPoints[i][0]*_scale-sign(polygonPoints[i][0]))/RES_WIDTH, (y+polygonPoints[i][1]*_scale-sign(polygonPoints[i][1])) / RES_HEIGHT);
        draw_vertex_texture(x+polygonPoints[j][0]*_scale-sign(polygonPoints[j][0]), y+polygonPoints[j][1]*_scale-sign(polygonPoints[j][1]), (x+polygonPoints[j][0]*_scale-sign(polygonPoints[j][0]))/RES_WIDTH, (y+polygonPoints[j][1]*_scale-sign(polygonPoints[j][1])) / RES_HEIGHT);
    }
    draw_primitive_end();
}



shader_reset();
