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
	
	// Draw secondary buttons with hover effects
	draw_secondary_buttons();
}

//page 2
if (page = 2) {
	draw_set_valign(fa_middle);
	draw_set_halign(fa_left);
	draw_sprite(spr_pages, 1, x + sprite_width, y);
	
	// Draw secondary buttons with hover effects
	draw_secondary_buttons();
}

// Function to draw secondary buttons with hover effects
function draw_secondary_buttons() {
	for (var i = 0; i < array_length(secondary_buttons); i++) {
		var btn = secondary_buttons[i];
		
		// Check if mouse is hovering over this button
		var is_hovered = (mouse_x >= btn.x && mouse_x <= btn.x + btn.width &&
						  mouse_y >= btn.y && mouse_y <= btn.y + btn.height);
		
		// Draw button background rectangle
		if (is_hovered) {
			draw_set_color(c_yellow);
			draw_rectangle_color(btn.x - 5, btn.y - 5, btn.x + string_width(btn.text) + 5, btn.y + string_height(btn.text) + 5, c_green, c_green, c_green, c_green, true);
		} else {
			draw_set_color(c_green);
		}
		
		// Draw button text
		draw_set_valign(fa_middle);
		draw_set_halign(fa_left);
		draw_text(btn.x, btn.y + btn.height/2, btn.text);
	}
}