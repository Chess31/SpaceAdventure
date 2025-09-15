/// @description Simplified Grid Shader - Retro Style Only

/// @description Draw retro grid background with shader
function draw_retro_grid() {
    if (shader_is_compiled(shd_GRID)) {
        // Draw a center rectangle to test the shader
        var centerX = room_width / 2 - 200;
        var centerY = room_height / 2 - 150;
        var rectWidth = 400;
        var rectHeight = 300;
        
        shader_set(shd_GRID);
        
        // Set basic uniforms - simplified for visibility
        shader_set_uniform_f(shader_get_uniform(shd_GRID, "u_time"), current_time / 1000.0);
        shader_set_uniform_f(shader_get_uniform(shd_GRID, "u_resolution"), rectWidth, rectHeight);
        shader_set_uniform_f(shader_get_uniform(shd_GRID, "u_enableRainbow"), 0.0);
        shader_set_uniform_f(shader_get_uniform(shd_GRID, "u_gridColor"), 0.0, 1.0, 0.0);
        shader_set_uniform_f(shader_get_uniform(shd_GRID, "u_rippleIntensity"), 0.1);
        shader_set_uniform_f(shader_get_uniform(shd_GRID, "u_gridSize"), 5.0);  // Smaller grid for visibility
        shader_set_uniform_f(shader_get_uniform(shd_GRID, "u_gridThickness"), 10.0);  // Thinner lines
        shader_set_uniform_f(shader_get_uniform(shd_GRID, "u_fadeDistance"), 1.0);  // Less fade
        shader_set_uniform_f(shader_get_uniform(shd_GRID, "u_vignetteStrength"), 1.0);  // Less vignette
        shader_set_uniform_f(shader_get_uniform(shd_GRID, "u_glowIntensity"), 0.5);  // More glow
        shader_set_uniform_f(shader_get_uniform(shd_GRID, "u_opacity"), 1.0);
        shader_set_uniform_f(shader_get_uniform(shd_GRID, "u_gridRotation"), 0.0);
        shader_set_uniform_f(shader_get_uniform(shd_GRID, "u_mouseInteraction"), 1.0);
        shader_set_uniform_f(shader_get_uniform(shd_GRID, "u_mouseInteractionRadius"), 1.0);
        
        // Mouse position relative to the center rectangle
        var mouseX = (device_mouse_x_to_gui(0) - centerX) / rectWidth;
        var mouseY = (device_mouse_y_to_gui(0) - centerY) / rectHeight;
        shader_set_uniform_f(shader_get_uniform(shd_GRID, "u_mousePosition"), mouseX, mouseY);
        
        // Mouse influence
        var mouseInfluence = (mouseX >= 0 && mouseX <= 1 && mouseY >= 0 && mouseY <= 1) ? 1.0 : 0.0;
        shader_set_uniform_f(shader_get_uniform(shd_GRID, "u_mouseInfluence"), mouseInfluence);
        
        // Draw a center rectangle with the shader using draw_rectangle
        draw_rectangle(centerX, centerY, centerX + rectWidth, centerY + rectHeight, false);
        
        shader_reset();
        
        // Draw a border around the test area for visibility (wireframe only)
        draw_set_color(c_red);
        draw_rectangle(centerX, centerY, centerX + rectWidth, centerY + rectHeight, true);
        draw_set_color(c_white);
        
    } else {
        // Debug: Draw a simple red rectangle if shader fails
        draw_set_color(c_red);
        draw_rectangle(0, 0, 100, 100, false);
        draw_set_color(c_white);
    }
}