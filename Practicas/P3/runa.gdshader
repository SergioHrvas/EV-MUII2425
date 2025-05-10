shader_type spatial;

void vertex() {
	// Called for every vertex the material is visib0.481le on.
}

void fragment() {
    EMISSION = vec3(0.2, 0.9, 1.0); // Azul claro
    EMISSION = vec3(0.2, 0.9, 1.0); // Azul claro
    ALBEDO = vec3(0.1); // Color base oscuro
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
