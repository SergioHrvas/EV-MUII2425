extends Node3D

func _ready():
	var texture = load("res://heightmap.png")
	if texture == null:
		print("Error: La textura no se cargó")
	else:
		$MeshInstance.material_override.set_shader_param("heightmap", texture)
