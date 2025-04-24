shader_type spatial;


void vertex() {
	// Called for every vertex the material is visible on.
}


// Textura de altura para calcular las normales
uniform sampler2D heightmap;
// Factor para ajustar la intensidad del efecto
uniform float bump_scale : hint_range(0, 1) = 1;

void fragment() {
    vec2 uv = UV;

    // Tamaño de un texel
    vec2 texel_size = 1.0 / vec2(textureSize(heightmap, 0));
    
	// 1. Comprobar la altura del mapa que corresponde a la superficie
    // Muestra vecinas para calcular derivadas (diferencias centrales)
    float hL = texture(heightmap, uv - vec2(texel_size.x, 0.0)).r; // izquierda
    float hR = texture(heightmap, uv + vec2(texel_size.x, 0.0)).r; // derecha
    float hD = texture(heightmap, uv - vec2(0.0, texel_size.y)).r; // abajo
    float hU = texture(heightmap, uv + vec2(0.0, texel_size.y)).r; // arriba

	// Calcular la normal a la superficie en el mapa de altura
    // Derivadas de altura
    float dx = (hR - hL) * bump_scale;
    float dy = (hU - hD) * bump_scale;

   // Normal perturbada en espacio tangente
    vec3 bump_normal = normalize(vec3(-dx, -dy, 1.0));

    // Construcción de la base TBN (asumiendo superficie plana en espacio local)
    vec3 normal = normalize(NORMAL);
    vec3 tangent = normalize(TANGENT);
	vec3 binormal = normalize(cross(normal, tangent));

    // Transformar la normal del bump al espacio del fragmento
    mat3 TBN = mat3(tangent, binormal, normal);
    vec3 final_normal = normalize(TBN * bump_normal);

    // Aplicar la normal resultante
    NORMAL = final_normal;s

    // Color en escala de grises según altura, o cambia por tu textura
    ALBEDO = vec3(texture(heightmap, uv).r);
}
