extends MeshInstance3D

func _ready():
	var surface_array = []
	surface_array.resize(Mesh.ARRAY_MAX)

	# PackedVector**Arrays for mesh construction.
	var verts = PackedVector3Array()
	var indices = PackedInt32Array()

	#######################################

	#Definimos  los vert
	verts.append(Vector3(-1, -1,  1))
	verts.append(Vector3( 1, -1,  1))
	verts.append(Vector3( 1,  1,  1))
	verts.append(Vector3(-1,  1,  1))
	verts.append(Vector3(-1, -1, -1))
	verts.append(Vector3( 1, -1, -1))
	verts.append(Vector3( 1,  1, -1))
	verts.append(Vector3(-1,  1, -1))
	
	indices.append_array([
		0, 1, 2, 0, 2, 3, # Cara frontal
		4, 6, 5, 4, 7, 6, # Cara trasera
		3, 2, 6, 3, 6, 7, # Cara superior
		0, 5, 1, 0, 4, 5, # Cara inferior
		1, 6, 2, 1, 5, 6, # Cara derecha
		0, 7, 4, 0, 3, 7  # Cara izquierda
	])
	#######################################

	# Assign arrays to surface array.
	surface_array[Mesh.ARRAY_VERTEX] = verts
	surface_array[Mesh.ARRAY_INDEX] = indices

	# Create mesh surface from mesh array.
	# No blendshapes, lods, or compression used.
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, surface_array)
	
	# Crear un material y asignarle un color
	var material = StandardMaterial3D.new()
	material.albedo_color = Color(0.0, 1.0, 0.0) # Color verde, puedes cambiarlo como desees
	
	# Asignar el material a la malla
	mesh.surface_set_material(0, material)
