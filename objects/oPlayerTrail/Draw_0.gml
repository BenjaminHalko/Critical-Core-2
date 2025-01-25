/// @desc 

draw_set_color(image_blend);

if (image_blend == c_ltgrey)
    drawCircleOutline(x, y, radius * percent);
else
    drawCircle(x,y,radius*percent,false);