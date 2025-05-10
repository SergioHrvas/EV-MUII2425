extends Node3D

const LAYER_MASK := 1 << 0  

func _ready():
	apply_layer_to_visuals(self, LAYER_MASK)

func apply_layer_to_visuals(node: Node, layer_mask: int) -> void:
	if node is VisualInstance3D:
		node.layers = layer_mask
		print("Aplicando capa a:", node.name)
	for child in node.get_children():
		apply_layer_to_visuals(child, layer_mask)
