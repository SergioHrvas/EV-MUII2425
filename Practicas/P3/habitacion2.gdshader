shader_type spatial;
render_mode blend_mix, unshaded;

uniform vec4 fog_color : source_color = vec4(0.5, 1.0, 0.5, 1); // Verde mágico translúcido
uniform float speed = 0.05;
uniform float scale = 2.5;
uniform float intensity = 1.0;

void fragment() {
    vec2 uv = UV * scale;
    uv.x += TIME * speed;
    uv.y += sin(UV.x * 10.0 + TIME * speed) * 0.2;

    float pattern = sin(uv.x * 3.0 + TIME) * cos(uv.y * 3.0 - TIME);
    pattern = abs(pattern); // Asegura valores positivos

    float mask = smoothstep(0.3, 0.6, pattern); // Ajusta el umbral de visibilidad

    ALBEDO = fog_color.rgb;
    ALPHA = (1.0 - mask) * fog_color.a;
}
