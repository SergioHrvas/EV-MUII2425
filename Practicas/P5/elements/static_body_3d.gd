extends StaticBody3D

signal palanca_activada

var anim_player: AnimationPlayer

func _ready():
	anim_player = get_parent().get_node("AnimationPlayer")


func activar():
		# 1. Subimos al nodo raíz "Habitacion1"
	var habitacion = get_parent().get_parent()  # porque estás en Palanca/Node3D/StaticBody
	
	# 2. Bajamos hasta el RigidBody dentro de Plataforma
	var rigid_body = habitacion.get_node("Plataforma1/StaticBody3D")
	var rigid_body2 = habitacion.get_node("Plataforma2/StaticBody3D")

	# 3. Consultamos la variable
	if rigid_body.bola_colocada or rigid_body2.bola_colocada:
		print("Bola colocada, palanca activada")
		# Reproducir sonido
		var sound = preload("res://sonidos/success.ogg")
		var player = AudioStreamPlayer.new()
		player.stream = sound
		add_child(player)
		player.play()		
		
		# Reproducir animación
		anim_player.play("palanca_giro")
		
		await player.finished
		player.queue_free()

	else:
		print("Aún no está la bola en la plataforma")
		# Reproducir sonido
		var sound = preload("res://sonidos/error.ogg")
		var player = AudioStreamPlayer.new()
		player.stream = sound
		add_child(player)
		player.play()
		
		# Reproducir animación
		anim_player.play("palanca_no_giro")
		
		await player.finished
		player.queue_free()


# Esta función será llamada por el AnimationPlayer
func emit_activation_signal():
	print("EMITIENDO SEÑAL PALANCA")
	emit_signal("palanca_activada")
