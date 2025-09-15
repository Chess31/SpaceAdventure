/// @description Game Setup

// CRT Effect Parameters
barrel_power = 1.03;        // Barrel distortion: 0.5 = strong, 1.0 = none, 1.5 = pincushion
scanline_intensity = 0.1;  // Scanline darkness: 0.0 = none, 1.0 = very dark
vignette_strength = 0.3;   // Vignette darkness: 0.0 = none, 1.0 = very dark
color_bleeding = 0.08;     // Color bleeding: 0.0 = none, 1.0 = strong

//set font for text
draw_set_font(ft_Retro);

//do not auto draw application surface
application_surface_draw_enable(false);

//do not show cursor (draw it so it gets post processed)
window_set_cursor(cr_none);

// Initialize the text adventure system
text_adventure_init();