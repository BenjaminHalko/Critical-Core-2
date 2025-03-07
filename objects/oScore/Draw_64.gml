/// @desc 

draw_set_font(fScore);
draw_set_color(negative ? c_red : (double ? #61FFA0 : c_white));
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);

var _amount = negative ? $"-{amount}": (double ? $"{amount}x3" : string(amount));

draw_set_alpha(image_alpha);
draw_text((x-camera_get_view_x(oCamera.cam))*(RES_WIDTH/oCamera.viewWidth),(y-camera_get_view_y(oCamera.cam))*(RES_WIDTH/oCamera.viewWidth)-16*(1-image_alpha),_amount);
draw_set_alpha(1);