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
    show_debug_message("Change Color activated!");
    
    // Example: Cycle through different color schemes
    if (!variable_global_exists("color_scheme")) {
        globalvar color_scheme;
        color_scheme = 0;
    }
    
    color_scheme++;
    if (color_scheme > 2) color_scheme = 0;
    
    // Example color schemes
    switch (color_scheme) {
        case 0:
            // Default green terminal
            break;
        case 1:
            // Blue terminal
            break;
        case 2:
            // Red terminal
            break;
    }
}

// Switch Font Action
function menu_switch_font() {
    show_debug_message("Switch Font activated!");
    
    // Example: Cycle through different fonts
    if (!variable_global_exists("font_index")) {
        globalvar font_index;
        font_index = 0;
    }
    
    font_index++;
    if (font_index > 1) font_index = 0;
    
    // Switch between available fonts
    switch (font_index) {
        case 0:
            draw_set_font(ft_Retro);
            break;
        case 1:
            // Add another font if you have one
            draw_set_font(ft_Retro);
            break;
    }
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
