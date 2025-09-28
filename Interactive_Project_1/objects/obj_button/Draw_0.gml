//default
draw_self();
draw_set_color(c_yellow);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_text(x + 110, y - 32, "System Control");
//page 1
if (page = 1) {
	draw_set_valign(fa_middle);
	draw_set_halign(fa_left);
	draw_sprite(spr_pages, 0, x + sprite_width, y);
	draw_text(x + sprite_width + 50, y - 180, "RESET TERMINAL");
	draw_text(x + sprite_width + 50, y - 120, "CHANGE COLOR");
	draw_text(x + sprite_width + 50, y - 60, "SWITCH FONT");
}
//page 2
if (page = 2) {
	draw_set_valign(fa_middle);
	draw_set_halign(fa_left);
	draw_sprite(spr_pages, 1, x + sprite_width, y);
	draw_text(x + sprite_width + 50, y - 180, "UNLOCK ARCHIVE");
	draw_text(x + sprite_width + 50, y - 120, "CHANGE COLOR");
	draw_text(x + sprite_width + 50, y - 60, "SWITCH FONT");
}