extends Node3D

func activar():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	get_parent().get_parent().get_parent().get_parent().get_parent().get_node("End").visible = true
