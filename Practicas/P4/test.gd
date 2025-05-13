extends Node
signal activar_avatar
signal activar_vigilante

func _input(event):
	if event.is_action_pressed("cambiar_camara"):  # Tecla "C" configurada
		if get_parent().get_node("Habitacion1/Avatar/Pitch/Camera3D").current:
			emit_signal("activar_vigilante")
			get_parent().get_node("Panel/Label2").set_visible(false)
			get_parent().get_node("Panel/Label").text = "C = Cambiar a Avatar"

		else:
			emit_signal("activar_avatar")
			get_parent().get_node("Panel/Label2").set_visible(true)
			get_parent().get_node("Panel/Label").text = "C = Cambiar a Vigilante"
