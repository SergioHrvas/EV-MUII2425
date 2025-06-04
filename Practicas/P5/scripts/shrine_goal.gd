extends Node3D

# Activacion de la interfaz final tras interactuar con monumento
func activar():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_parent().get_parent().get_parent().get_parent().get_parent().get_node("End").visible = true
