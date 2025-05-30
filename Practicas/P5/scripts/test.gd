extends Node
signal activar_avatar
signal activar_vigilante


# Cambiamos el texto de la interfaz en funcion de la camara
func _input(event):
	if event.is_action_pressed("cambiar_camara"): 
		if get_parent().get_node("Avatar/Pivot/Pitch/Camera3D").current:
			emit_signal("activar_vigilante")
			get_parent().get_node("HUD/Panel/Label2").set_visible(false)
			get_parent().get_node("HUD/Panel/Label").text = "C = Cambiar a Avatar"

		else:
			emit_signal("activar_avatar")
			get_parent().get_node("HUD/Panel/Label2").set_visible(true)
			get_parent().get_node("HUD/Panel/Label").text = "C = Cambiar a Vigilante"
