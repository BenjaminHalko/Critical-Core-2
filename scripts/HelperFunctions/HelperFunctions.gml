	/// @desc Moves "a" towards "b" by "amount" and returns the result
/// @param {Real} a The value to change
/// @param {Real} b The target value
/// @param {Real} amount The amount to move by
/// @return {Real}
function Approach(_a, _b, _amount)
{
	if (_a < _b)
	{
		_a += _amount;
	    if (_a > _b)
	        return _b;
	}
	else
	{
	    _a -= _amount;
	    if (_a < _b)
	        return _b;
	}
	return _a;
}

/// @desc Moves a value to a target value with easing.
/// @param {Real} Value The target value
/// @param {Real} Target The target value
/// @param {Real} MaxSpd The maximum speed
/// @param {Real} Ease The ease amount from 0 - 1
/// @return {Real}
function ApproachFade(_value,_target,_maxSpd,_ease)
{
	_value += median(-_maxSpd,_maxSpd,(1-_ease)*(_target-_value));
	return _value
}

/// @desc Moves a value to a target value with easing, used for circles
/// @param {Real} Value The target value
/// @param {Real} Target The target value
/// @param {Real} MaxSpd The maximum speed
/// @param {Real} Ease The ease amount from 0 - 1
/// @return {Real}
function ApproachCircleEase(_value,_target,_maxSpd,_ease)
{
	_value += median(-_maxSpd,_maxSpd,(1-_ease)*angle_difference(_target,_value));
	return _value
}

/// @desc Turns {x} into a percent from {a} to {b}
/// @param {Real} x The value to turn into a percent
/// @param {Real} a The min value
/// @param {Real} b The max value
/// @return {Real}
function ValuePercent(_x, _a, _b) {
	return (_x - _a) / (_b - _a)
}

/// @desc Returns a value that will wave back and forth between [from-to] over [duration] seconds
/// @param {Real} from The minimum wave range
/// @param {Real} to The maximum wave range
/// @param {Real} duration The duration of the wave in seconds
/// @param {Real} offset The offset of the wave from 0 to 1
/// @return {Real}
function Wave(_from, _to, _duration, _offset) {
	var a4 = (_to - _from) * 0.5;
	return _from + a4 + sin((((current_time * 0.001) + _duration * _offset) / _duration) * (pi*2)) * a4;
}

/// @desc Returns the value wrapped, values over or under will be wrapped around
/// @param {Real} value
/// @param {Real} min
/// @param {Real} max
/// @return {Real}
function Wrap(_value, _min, _max) {
	if (_value mod 1 == 0)
	{
	    while (_value > _max || _value < _min)
	    {
	        if (_value > _max)
	            _value += _min - _max - 1;
	        else if (_value < _min)
	            _value += _max - _min + 1;
	    }
	    return(_value);
	}
	else
	{
	    var _valueOld = _value + 1;
	    while (_value != _valueOld)
	    {
	        _valueOld = _value;
	        if (_value < _min)
	            _value = _max - (_min - _value);
	        else if (_value > _max)
	            _value = _min + (_value - _max);
	    }
	    return(_value);
	}

}

/// @desc	rotates a vector by an angle
/// @param	{real} x
/// @param	{real} y
/// @param	{real} angle
function RotateVector(_x, _y, _angle) {
	var _dist = point_distance(0,0,_x,_y);
	var _dir = point_direction(0,0,_x,_y);
	return {
		x: lengthdir_x(_dist, _dir+_angle),
		y: lengthdir_y(_dist, _dir+_angle)
	}
}

function drawCircle(_x, _y, _radius, _bubble=true) {
    var _offset = 0.5 + (!BROWSER and !OPERA)*0.5;
    
	
	if (_bubble) {
        draw_circle(_x-_offset, _y-_offset, _radius, false);
        
        // Outline
		var _currentColor = draw_get_color();
		var _newSat = color_get_saturation(_currentColor) * 0.3;
		draw_set_color(make_color_hsv(
			color_get_hue(_currentColor),
			_newSat,
			color_get_value(_currentColor)
		));
		draw_circle(_x-_offset, _y-_offset, _radius, true);
	} else {
        draw_circle(_x-_offset, _y-_offset, _radius, false);
    }
}

function drawCircleOutline(_x, _y, _radius) {
	var _offset = 0.5 + (!BROWSER and !OPERA)*0.5;
	draw_circle(_x-_offset, _y-_offset, _radius, true);
}

function Save(_section, _key, _value) {
	ini_open(SAVEFILE);
	if is_real(_value) ini_write_real(_section, _key, _value);
	else ini_write_string(_section, _key, _value);
	ini_close();
}

function RenderConverArt(_sprite) {
	var _width = sprite_get_width(_sprite)+8;
	var _height = sprite_get_height(_sprite)+8;
	var _surfacePing = surface_create(_width,_height);
	var _surfacePong = surface_create(_width,_height);
	var _uniform = shader_get_uniform(shBlur, "blur_vector");

	surface_set_target(_surfacePing);
	draw_sprite(_sprite,0,_width/2,_height/2);
	surface_reset_target();

	surface_set_target(_surfacePong);
	shader_set(shBlur);
	shader_set_uniform_f(_uniform,0,1);
	draw_surface(_surfacePing,0,0);
	surface_reset_target();

	surface_set_target(_surfacePing);
	shader_set_uniform_f(_uniform,1,0);
	draw_surface_ext(_surfacePong,0,0,1,1,0,make_color_hsv(0,0,255*0.9),1);
	shader_reset();

	gpu_set_blendmode(bm_add);
	draw_sprite_ext(_sprite,0,_width/2,_height/2,1,1,0,make_color_hsv(0,0,255*0.55),1);
	gpu_set_blendmode(bm_normal);
	surface_reset_target();

	var _file = get_save_filename("*.png","CoverArt.png");
	surface_save(_surfacePing,_file);

	surface_free(_surfacePing);
	surface_free(_surfacePong);	
}