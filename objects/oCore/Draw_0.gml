/// @desc 

EnableLive;

// Draw Dash Line
if (dashLineAmount > 0 and movementPercent != 1) {
	var _dist = point_distance(x, y, targetX, targetY) * dashLineAmount;
	var _dir =  point_direction(x, y, targetX, targetY);
	
	draw_sprite_ext(sCoreTargetLine, 1, x + lengthdir_x(_dist, _dir), y + lengthdir_y(_dist, _dir), (_dist) / 5, 1, _dir-180, c_white, 1);
	//draw_sprite(sCoreTargetLine, 0, x + lengthdir_x(_dist, _dir)-3, y + lengthdir_y(_dist, _dir));
}


if (hpDraw > 0.05) {
    draw_set_color(c_white);
    shader_set(shCore);
    shader_set_uniform_f(uTime, current_time * 0.0005);
    shader_set_uniform_f(uResolution, RES_WIDTH/2, RES_HEIGHT/2);
    shader_set_uniform_f(uGreyscale, 1);
    
    draw_primitive_begin(pr_trianglelist);
    var _scale = max(scale*hpDraw, 0.05);
    for(var i = 0; i < array_length(polygonPoints); i++) {
        var j = (i + 1) % array_length(polygonPoints);
        draw_vertex_texture(x,y,x / room_width,y / room_height);
        draw_vertex_texture(x+polygonPoints[i][0]*_scale-sign(polygonPoints[i][0]), y+polygonPoints[i][1]*_scale-sign(polygonPoints[i][1]), (x+polygonPoints[i][0]*_scale-sign(polygonPoints[i][0]))/room_width, (y+polygonPoints[i][1]*_scale-sign(polygonPoints[i][1])) / room_height);
        draw_vertex_texture(x+polygonPoints[j][0]*_scale-sign(polygonPoints[j][0]), y+polygonPoints[j][1]*_scale-sign(polygonPoints[j][1]), (x+polygonPoints[j][0]*_scale-sign(polygonPoints[j][0]))/room_width, (y+polygonPoints[j][1]*_scale-sign(polygonPoints[j][1])) / room_height);
    }
    draw_primitive_end();
}

/*
if (hpDraw != 1) {
    shader_set_uniform_f(uGreyscale, 0);
    draw_primitive_begin(pr_trianglelist);
    draw_set_color(c_black);
    var _x = x + random_range(-(1-hp), (1-hp));
    var _y = y + random_range(-(1-hp), (1-hp));
    for(var i = 0; i < array_length(polygonPoints); i++) {
        var j = (i + 1) % array_length(polygonPoints);
        draw_vertex_texture(_x,_y,0.5,0.5);
        draw_vertex_texture(_x+polygonPoints[i][0]*scale*(1-hp)-sign(polygonPoints[i][0]), _y+polygonPoints[i][1]*scale*(1-hp)-sign(polygonPoints[i][1]), ValuePercent(_x+polygonPoints[i][0]*scale*(1-hp)-sign(polygonPoints[i][0]), bbox_left, bbox_right), ValuePercent(_y+polygonPoints[i][1]*scale*(1-hp)-sign(polygonPoints[i][1]), bbox_top, bbox_bottom));
        draw_vertex_texture(_x+polygonPoints[j][0]*scale*(1-hp)-sign(polygonPoints[j][0]), _y+polygonPoints[j][1]*scale*(1-hp)-sign(polygonPoints[j][1]), ValuePercent(_x+polygonPoints[j][0]*scale*(1-hp)-sign(polygonPoints[j][0]), bbox_left, bbox_right), ValuePercent(_y+polygonPoints[j][1]*scale*(1-hp)-sign(polygonPoints[j][1]), bbox_top, bbox_bottom));
    }
    draw_primitive_end();
}*/

shader_reset();
