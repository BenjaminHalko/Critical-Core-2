/// @desc 

EnableLive;

// Draw Dash Line
if (dashLineAmount > 0) {
	var _dist = point_distance(x, y, targetX, targetY) * dashLineAmount;
	var _dir =  point_direction(x, y, targetX, targetY);
	
	draw_sprite_ext(sCoreTargetLine, 1, x + lengthdir_x(_dist, _dir), y + lengthdir_y(_dist, _dir), (_dist) / 5, 1, _dir-180, c_white, 1);
	//draw_sprite(sCoreTargetLine, 0, x + lengthdir_x(_dist, _dir)-3, y + lengthdir_y(_dist, _dir));
}


draw_set_color(c_white);
draw_primitive_begin(pr_trianglelist);
for(var i = 0; i < array_length(polygonPoints); i++) {
	var j = (i + 1) % array_length(polygonPoints);
	draw_vertex(x,y);
	draw_vertex(x+polygonPoints[i][0]*scale-sign(polygonPoints[i][0]), y+polygonPoints[i][1]*scale-sign(polygonPoints[i][1]));
	draw_vertex(x+polygonPoints[j][0]*scale-sign(polygonPoints[j][0]), y+polygonPoints[j][1]*scale-sign(polygonPoints[j][1]));
}
draw_primitive_end();

if (hpDraw != 1) {
	draw_set_color(merge_color(#EE5F8D, #EE003B, pulse));
	draw_primitive_begin(pr_trianglelist);
	for(var i = 0; i < array_length(polygonPoints); i++) {
		var j = (i + 1) % array_length(polygonPoints);
		
		var _point1 = RotateVector(polygonPoints[i][0], polygonPoints[i][1], 0);
		var _point2 = RotateVector(polygonPoints[j][0], polygonPoints[j][1], 0);
		draw_vertex(x,y);
		draw_vertex(x+_point1.x*scale*(1-hpDraw)-sign(_point1.x), y+_point1.y*scale*(1-hpDraw)-sign(_point1.y));
		draw_vertex(x+_point2.x*scale*(1-hpDraw)-sign(_point2.x), y+_point2.y*scale*(1-hpDraw)-sign(_point2.y));
	}
	draw_primitive_end();
}
