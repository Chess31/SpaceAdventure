// Menu Action Functions
// This script contains the functions that can be called by menu buttons

function menu_change_color() {
    // Cycle through different color schemes
    
    color_scheme++;
    if (color_scheme > 2) color_scheme = 0;
    
    // Set color schemes
    switch (color_scheme) {
        case 0:
            // Default green terminal
            color_main = c_green;
            color_alt = c_yellow;
            break;
        case 1:
            // Blue terminal
            color_main = c_blue;
            color_alt = c_aqua;
            break;
        case 2:
            // Red terminal
            color_main = c_red;
            color_alt = c_orange;
            break;
    }
}

// Switch Font Action
function menu_switch_font() {
    // Cycle through different fonts
    font_index++;
    if (font_index > 4) font_index = 0;
    
    // Switch between available fonts
    switch (font_index) {
        case 0:
            current_font = ft_Retro;
            break;
        case 1:
            current_font = ft_Funny;
            break;
		case 2:
            current_font = ft_Funny2;
            break;
		case 3:
            current_font = ft_Funny3;
            break;
		case 4:
            current_font = ft_Funny4;
            break;
    }
    
    // Update the global font setting
    draw_set_font(current_font);
}