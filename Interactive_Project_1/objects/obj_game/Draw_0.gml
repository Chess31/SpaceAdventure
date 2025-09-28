/// @description Draw Game

// Draw retro grid background
//draw_retro_grid();

// Draw the rest of the game content
draw_set_color(color_main);
draw_line(room_width-1, 0, room_width-1, room_height);
draw_line(0, room_height-1, room_width, room_height-1);
draw_line(0, 0, 0, room_height);
draw_line(0, 0, room_width-1, 0);

// Draw the text adventure interface
text_adventure_draw();