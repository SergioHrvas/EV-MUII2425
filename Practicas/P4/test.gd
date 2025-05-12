extends Node
signal activar_avatar
signal activar_vigilante

func _input(event):
	if event.is_action_pressed("cambiar_camara"):  # Tecla "C" configurada
		if get_parent().get_node("Habitacion1/Avatar/Pitch/Camera3D").current:
			emit_signal("activar_vigilante")
		else:
			emit_signal("activar_avatar")
