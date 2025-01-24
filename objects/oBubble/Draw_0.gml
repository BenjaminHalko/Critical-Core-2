/// @desc 

EnableLive;

switch(state) {
	default:
		draw_set_color(#9400DD);
	break;
	case BUBBLE_STATE.DOUBLE_POINTS:
		draw_set_color(#61FFA0);
	break;
	case BUBBLE_STATE.WEAPON:
		draw_set_color(#EEE212);
	break;
}

drawCircle(x,y,radius);
