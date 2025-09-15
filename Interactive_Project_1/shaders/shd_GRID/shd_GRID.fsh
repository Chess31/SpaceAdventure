//
// Simple Grid Test Shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// Uniforms - these will be set from GameMaker code
uniform float u_time;                    // iTime equivalent
uniform vec2 u_resolution;               // iResolution equivalent
uniform bool u_enableRainbow;            // Rainbow mode toggle
uniform vec3 u_gridColor;                // Grid color (RGB)
uniform float u_rippleIntensity;         // Ripple effect intensity
uniform float u_gridSize;                // Grid size
uniform float u_gridThickness;           // Grid line thickness
uniform float u_fadeDistance;            // Fade distance from center
uniform float u_vignetteStrength;        // Vignette effect strength
uniform float u_glowIntensity;           // Glow effect intensity
uniform float u_opacity;                 // Overall opacity
uniform float u_gridRotation;            // Grid rotation in degrees
uniform bool u_mouseInteraction;         // Enable mouse interaction
uniform vec2 u_mousePosition;            // Mouse position (0-1)
uniform float u_mouseInfluence;          // Mouse influence strength
uniform float u_mouseInteractionRadius;  // Mouse interaction radius

void main()
{
    // Simple grid pattern
    vec2 uv = v_vTexcoord;
    
    // Create grid lines
    vec2 grid = fract(uv * u_gridSize);
    float gridLine = step(0.95, grid.x) + step(0.95, grid.y);
    
    // Make grid lines bright green
    vec3 color = vec3(0.0, 1.0, 0.0) * gridLine;
    
    // Add some background color so we can see the grid
    color += vec3(0.0, 0.2, 0.0) * (1.0 - gridLine);
    
    gl_FragColor = vec4(color, 1.0) * v_vColour;
}
