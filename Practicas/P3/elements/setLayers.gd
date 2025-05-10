extends Node

# Establece la capa de luz recursivamente para que llegue a todos los nodos del cofre
func set_visual_layer_recursively(node: Node, layer_mask: int) -> void:
	if node is VisualInstance3D:
		node.layers = layer_mask
	for child in node.get_children():
		set_visual_layer_recursively(child, layer_mask)
