// Menu Action Functions
// This script contains all the functions that can be called by menu buttons

// Terminal Reset Action
function menu_reset_terminal() {
    show_debug_message("Terminal Reset activated!");
    
    // Example: Reset text adventure to start
    if (variable_global_exists("current_scene")) {
        text_adventure_start_scene("start");
    }
    
    // Example: Clear any terminal history
    // Add your terminal reset logic here
}

// Change Color Action
function menu_change_color() {
    // Cycle through different color schemes
    if (!variable_global_exists("color_scheme")) {
        globalvar color_scheme;
        color_scheme = 0;
    }
    
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
            color_alt = c_cyan;
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
    if (font_index > 1) font_index = 0;
    
    // Switch between available fonts
    switch (font_index) {
        case 0:
            current_font = ft_Retro;
            break;
        case 1:
            current_font = ft_Funny;
            break;
    }
    
    // Update the global font setting
    draw_set_font(current_font);
}

// Unlock Archive Action
function menu_unlock_archive() {
    show_debug_message("Unlock Archive activated!");
    
    // Example: Unlock special content or endings
    if (!variable_global_exists("archive_unlocked")) {
        globalvar archive_unlocked;
        archive_unlocked = false;
    }
    
    archive_unlocked = true;
    
    // Example: Show special message or unlock new scenes
    show_debug_message("Archive unlocked! New content available.");
    
    // You could trigger a special scene or ending here
    // text_adventure_start_scene("secret_ending");
}
