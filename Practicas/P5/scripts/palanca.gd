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
	var soporte_gancho = habitacion.get_node("SoporteGancho")
	
	print(soporte_gancho.gancho_colocado)
	# 3. Consultamos la variable
	if true or (rigid_body.bola_colocada and rigid_body2.bola_colocada and soporte_gancho.gancho_colocado):
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
		print("Aún no están las bolas en las plataformas")
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
	emit_signal("palanca_activada")
