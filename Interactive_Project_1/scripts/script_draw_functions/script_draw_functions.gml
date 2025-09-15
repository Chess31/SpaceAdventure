function draw_line_grid(){
	//// Draw grid
	//var _spacing = room_width / 16;
	//draw_set_color(c_white);

	//// Vertical lines
	//for (var i = 0; i < 16; ++i) {
	//    var _x = i * _spacing;
	//    draw_line(_x, 0, _x, room_height);
	//}
	//// Horizontal lines
	//for (var i = 0; i < 9; ++i) {
	//    var _y = i * _spacing;
	//    draw_line(0, _y, room_width, _y);
	//}
	
	//Edges
	draw_set_color(c_green);
	draw_line(room_width-1, 0, room_width-1, room_height);
	draw_line(0, room_height-1, room_width, room_height-1);
	draw_line(0, 0, 0, room_height);
	draw_line(0, 0, room_width-1, 0);
	draw_set_color(c_white);
}