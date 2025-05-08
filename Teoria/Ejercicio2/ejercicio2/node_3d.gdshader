shader_type spatial;


void vertex() {
	// No hacemos nada porque no alteramos la geometría
}

// Textura de altura para calcular las normales
uniform sampler2D heightmap;
// Factor para ajustar la intensidad del efecto
uniform float bump_scale : hint_range(0, 2) = 2;

void fragment() {
    vec2 uv = UV;

    // Calculamos el tamaño de un texel
    vec2 texel_size = 1.0 / vec2(textureSize(heightmap, 0));

	// Sacamos la altura de los vecinos (r porque al ser grises, todos los valores son iguales)
    float hL = texture(heightmap, uv - vec2(texel_size.x, 0.0)).r; // izquierda
    float hR = texture(heightmap, uv + vec2(texel_size.x, 0.0)).r; // derecha
    float hD = texture(heightmap, uv - vec2(0.0, texel_size.y)).r; // abajo
    float hU = texture(heightmap, uv + vec2(0.0, texel_size.y)).r; // arriba

	// Calculamos la normal a la superficie en el mapa de altura
    // Derivadas de altura (pendientes)
    float dx = (hR - hL) * bump_scale;
    float dy = (hU - hD) * bump_scale;

    // Vector normal en base a las dos pendientes
    vec3 bump_normal = normalize(vec3(-dx, -dy, 1.0));

    // Construimos la base TBN
    vec3 normal = normalize(NORMAL);
    vec3 tangent = normalize(TANGENT);
	vec3 binormal = normalize(cross(normal, tangent));

    // Transformamos la normal del bump al espacio del fragmento
    mat3 TBN = mat3(tangent, binormal, normal);
    vec3 final_normal = normalize(TBN * bump_normal);

    // Aplicamos la normal
    NORMAL = final_normal;
}
