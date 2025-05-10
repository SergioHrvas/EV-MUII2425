extends Node3D

const LAYER_MASK := 1 << 4  # Capa 5 (binario, desplazaria 4 veces el uno a la izquierda)

func _ready():
	apply_layer_to_visuals(self, LAYER_MASK)

func apply_layer_to_visuals(node: Node, layer_mask: int) -> void:
	if node is VisualInstance3D:
		node.layers = layer_mask
		print("Aplicando capa a:", node.name)
	for child in node.get_children():
		apply_layer_to_visuals(child, layer_mask)
