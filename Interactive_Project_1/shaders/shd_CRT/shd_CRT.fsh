//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float BarrelPower;
uniform vec2 Resolution;
uniform float ScanlineIntensity;
uniform float VignetteStrength;
uniform float ColorBleeding;

// Given a vec2 in [-1,+1], generate a texture coord in [0,+1]
vec2 Distort(vec2 p)
{
    float theta  = atan(p.y, p.x);
    float radius = length(p);
    radius = pow(radius, BarrelPower);
    p.x = radius * cos(theta);
    p.y = radius * sin(theta);
    return 0.5 * (p + 1.0);
}

void main()
{
    vec2 uv = v_vTexcoord * 2.0 - 1.0;
    vec2 distorted_uv = Distort(uv);
    
    // Add bounds check
    if (distorted_uv.x < 0.0 || distorted_uv.x > 1.0 || 
        distorted_uv.y < 0.0 || distorted_uv.y > 1.0) {
        gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0); // Black for out of bounds
        return;
    }
    
    // Sample the texture
    vec4 color = texture2D(gm_BaseTexture, distorted_uv);
    
    // Add scanlines (horizontal phosphor stripes)
    float scanline = sin(distorted_uv.y * Resolution.y * 3.14159) * ScanlineIntensity;
    color.rgb *= (1.0 - scanline);
    
    // Add vignette (darkened screen edges)
    float vignette = length(uv) * VignetteStrength;
    color.rgb *= (1.0 - vignette);
    
    // Add color bleeding (red shift)
    vec2 bleed_offset = vec2(0.001, 0.0);
    vec4 bleed_color = texture2D(gm_BaseTexture, distorted_uv + bleed_offset);
    color.r = mix(color.r, bleed_color.r, ColorBleeding);
    
    gl_FragColor = v_vColour * color;
}