/// @desc 

EnableLive;

var _currentColor = image_blend;
var _newSat = color_get_saturation(_currentColor) * 0.3;
	
draw_set_color(make_color_hsv(
	color_get_hue(_currentColor),
	_newSat,
	color_get_value(_currentColor)
));
drawCircleOutline(x, y, outerSize);

draw_set_color(image_blend);
var _x = x+random_range(-3, 3)*fireballChargeUp;
var _y = y+random_range(-3, 3)*fireballChargeUp;

shader_set(shCore);
shader_set_uniform_f(oCore.uTime, global.coreEffectTime);
shader_set_uniform_f(oCore.uResolution, RES_WIDTH/2, RES_HEIGHT/2);
shader_set_uniform_f(oCore.uIntensity, 0.5);
var _sides = 20;
draw_primitive_begin(pr_trianglestrip);
for(var i = 0; i < _sides; i++) {
    draw_vertex_texture(_x, _y, 0.5, 0.5);
    draw_vertex_texture(
        _x + lengthdir_x(radius, i / _sides * 360),
        _y + lengthdir_y(radius, i / _sides * 360),
        0.5 + lengthdir_x(radius, i / _sides * 360) / RES_WIDTH,
        0.5 + lengthdir_y(radius, i / _sides * 360) / RES_HEIGHT
    );
    draw_vertex_texture(
        _x + lengthdir_x(radius, (i + 1) / _sides * 360),
        _y + lengthdir_y(radius, (i + 1) / _sides * 360),
        0.5 + lengthdir_x(radius, (i + 1) / _sides * 360) / RES_WIDTH,
        0.5 + lengthdir_y(radius, (i + 1) / _sides * 360) / RES_HEIGHT
    );
}
draw_primitive_end();
shader_reset();

drawCircleOutline(x, y, radius);
