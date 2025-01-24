/// @desc 

EnableLive;

switch(state) {
	default:
		draw_set_color(#00DBDC);
	break;
	case BUBBLE_STATE.DOUBLE_POINTS:
		draw_set_color(#61FFA0);
	break;
	case BUBBLE_STATE.WEAPON:
		draw_set_color(#EE5E13);
	break;
}

drawCircle(x,y,radius);
