extends StaticBody3D

# Funcion de activar
func activar():
		# Reproducimos la animacion y el sonido
		get_parent().get_parent().get_node("AnimationPlayer").play("Scene")
		
		# Reproducir sonido
		var sound = preload("res://sonidos/chest.ogg")
		var player = AudioStreamPlayer.new()
		player.stream = sound
		add_child(player)
		player.play()
		
		#Mostramos la interfaz
		get_parent().get_parent().get_parent().get_parent().get_node("ChestOpened").visible = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		await player.finished
		player.queue_free()
