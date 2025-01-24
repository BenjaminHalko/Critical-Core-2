/// @desc 

for(var i = 0; i < array_length(walls); i++) {
	instance_destroy(walls[i].instance);	
}

layer_background_blend(bgLayer, c_black);