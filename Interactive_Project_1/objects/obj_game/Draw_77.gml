/// @description CRT Post Process

shader_set(shd_CRT);
// Set shader uniforms
shader_set_uniform_f(shader_get_uniform(shd_CRT, "BarrelPower"), barrel_power);
shader_set_uniform_f(shader_get_uniform(shd_CRT, "Resolution"), room_width, room_height);
shader_set_uniform_f(shader_get_uniform(shd_CRT, "ScanlineIntensity"), scanline_intensity);
shader_set_uniform_f(shader_get_uniform(shd_CRT, "VignetteStrength"), vignette_strength);
shader_set_uniform_f(shader_get_uniform(shd_CRT, "ColorBleeding"), color_bleeding);
//draw surface
draw_surface(application_surface,0,0);
shader_reset();