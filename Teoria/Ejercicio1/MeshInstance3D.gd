extends MeshInstance3D

func _ready():
	var surface_array = []
	surface_array.resize(Mesh.ARRAY_MAX)

	var verts = PackedVector3Array()
	var indices = PackedInt32Array()

	#######################################

	#Definimos los vertices (HORARIO)
	verts.append(Vector3(-1, -1,  1))
	verts.append(Vector3( 1, -1,  1))
	verts.append(Vector3( 1,  1,  1))
	verts.append(Vector3(-1,  1,  1))
	verts.append(Vector3(-1, -1, -1))
	verts.append(Vector3( 1, -1, -1))
	verts.append(Vector3( 1,  1, -1))
	verts.append(Vector3(-1,  1, -1))

	
	#Definimos las caras (HORARIO)
	indices.append_array([
		0, 2, 1, 0, 3, 2, # Cara frontal
		4, 5, 6, 4, 6, 7, # Cara trasera
		3, 6, 2, 3, 7, 6, # Cara superior
		0, 1, 5, 0, 5, 4, # Cara inferior
		1, 2, 6, 1, 6, 5, # Cara derecha
		0, 4, 7, 0, 7, 3  # Cara izquierda
	])
	
		
	#Definimos las caras (ANTI HORARIO) (no funciona)
	""" 
		indices.append_array([
		0, 1, 2, 0, 2, 3, # Cara frontal
		4, 6, 5, 4, 7, 6, # Cara trasera
		3, 2, 6, 3, 6, 7, # Cara superior
		0, 5, 1, 0, 4, 5, # Cara inferior
		1, 6, 2, 1, 5, 6, # Cara derecha
		0, 7, 4, 0, 3, 7  # Cara izquierda
	])
	"""
	#######################################

	# Asignar arrays a los arrays de superficie
	surface_array[Mesh.ARRAY_VERTEX] = verts
	surface_array[Mesh.ARRAY_INDEX] = indices

	# Creamos el mesh a partir de la superficie.
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, surface_array)
	
	# Crear un material y asignarle un color
	var material = StandardMaterial3D.new()
	material.albedo_color = Color(0.0, 1.0, 0.0) # Color verde
	
	# Asignar el material a la malla
	mesh.surface_set_material(0, material)

