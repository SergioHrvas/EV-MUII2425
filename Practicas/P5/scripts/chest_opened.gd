extends CanvasLayer

# Boton de cerrar
func _on_button_exit_button_up() -> void:
	visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
