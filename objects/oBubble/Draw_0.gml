/// @desc 

EnableLive;

switch(state) {
	default:
		draw_set_color(c_aqua);//#2ECBFF);
	break;
	case BUBBLE_STATE.DOUBLE_POINTS:
		draw_set_color(c_lime);//#14FF72);
	break;
	case BUBBLE_STATE.WEAPON:
		draw_set_color(c_fuchsia);//#FCE83C);
	break;
}

drawCircle(x,y,radius);
