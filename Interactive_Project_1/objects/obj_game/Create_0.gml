/// @description Game Setup

// CRT Effect Parameters
barrel_power = 1.05;        // Barrel distortion: 0.5 = strong, 1.0 = none, 1.5 = pincushion
scanline_intensity = 0.5;  // Scanline darkness: 0.0 = none, 1.0 = very dark
vignette_strength = 0.3;   // Vignette darkness: 0.0 = none, 1.0 = very dark
color_bleeding = 0.20;     // Color bleeding: 0.0 = none, 1.0 = strong

//secret ending variables
button_exists = false;
ending_exists = false;

// Global color system
globalvar color_main;
globalvar color_alt;
globalvar color_scheme;
color_scheme = 0;
color_main = c_green;
color_alt = c_yellow;

// Global font system
globalvar current_font;
current_font = ft_Retro;

//set font for text
draw_set_font(current_font);
globalvar font_index;
font_index = 0;

//do not auto draw application surface
application_surface_draw_enable(false);

//do not show cursor (draw it so it gets post processed)
window_set_cursor(cr_none);

// Initialize the text adventure system
text_adventure_init();