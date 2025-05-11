shader_type spatial;
render_mode blend_mix, unshaded, cull_disabled;

uniform vec4 fog_color : source_color = vec4(0.5, 1.0, 0.5, 1.0);
uniform float speed = 0.05;
uniform float scale = 2.5;
uniform float intensity = 1.0;
uniform float density = 0.8; // Densidad de la niebla
uniform float edge_softness = 0.4; // Suavidad de las bordes

void fragment() {
    // Coordenadas escaladas en movimiento
    vec2 uv = UV * scale;
    uv.x += TIME * speed * 2.5; //2.5 para que vaya mas rapido en x
    uv.y += TIME * speed * 0.4;

    // Generamos el ruido
    float noise = sin(uv.x * 5.0 + TIME) * cos(uv.y * 3.0 - TIME);

    // Aplicamos función de suavizado y ajustamos con la densidad
    float pattern = smoothstep(-0.5, 0.5, (noise) / 2.0) * density;

    // Aplicamos intensidad y suavizado de bordes
    float alpha = pow(pattern, 1.0 + (1.0 - edge_softness)) * intensity;

    // Resultado final
    ALBEDO = fog_color.rgb; //color
    ALPHA = alpha * fog_color.a; //transparencia
}