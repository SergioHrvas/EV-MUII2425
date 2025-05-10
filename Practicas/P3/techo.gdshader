shader_type spatial;
render_mode blend_mix, unshaded, cull_disabled;

uniform vec4 fog_color : source_color = vec4(0.5, 1.0, 0.5, 1.0);
uniform float speed = 0.05;
uniform float scale = 2.5;
uniform float intensity = 1.0;
uniform float density = 0.8; // Controla lo espesa que es la niebla
uniform float edge_softness = 0.4; // Suaviza los bordes del efecto

void fragment() {
    // Coordenadas escaladas con variación temporal
    vec2 uv = UV * scale;
    uv.x += TIME * speed * 0.5;
    uv.y += TIME * speed * 0.3;
    
    // Generamos múltiples capas de ruido para mayor complejidad
    float noise1 = sin(uv.x * 5.0 + TIME * 1.2) * cos(uv.y * 3.0 - TIME * 0.8);
    float noise2 = sin(uv.x * 2.0 - TIME * 0.3) * cos(uv.y * 7.0 + TIME * 0.5);
    float noise3 = sin((uv.x + uv.y) * 4.0 + TIME * 0.7);
    
    // Combinamos las capas de ruido
    float combined_noise = (noise1 + noise2 * 0.5 + noise3 * 0.3) / 1.8;
    
    // Aplicamos función de suavizado y ajustamos con densidad
    float pattern = smoothstep(-0.5, 0.5, combined_noise) * density;
    
    // Aplicamos intensidad y suavizado de bordes
    float alpha = pow(pattern, 1.0 + (1.0 - edge_softness)) * intensity;
    
    // Resultado final
    ALBEDO = fog_color.rgb;
    ALPHA = alpha * fog_color.a;
}