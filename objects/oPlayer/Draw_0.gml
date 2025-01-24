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

drawCircle(x+random_range(-3, 3)*fireballChargeUp,y+random_range(-3, 3)*fireballChargeUp,radius);
