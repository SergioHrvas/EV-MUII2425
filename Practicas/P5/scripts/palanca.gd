extends StaticBody3D

signal palanca_activada
var anim_player: AnimationPlayer

func _ready():
	anim_player = get_parent().get_node("AnimationPlayer")

# Activacion de la palanca tras interactuar con ella
func activar():
	var habitacion = get_parent().get_parent() 
	
	var rigid_body = habitacion.get_node("Plataforma1/StaticBody3D")
	var rigid_body2 = habitacion.get_node("Plataforma2/StaticBody3D")
	var soporte_gancho = habitacion.get_node("SoporteGancho")
	
	# Si tenemos las tres piezas del puzzle colocadas
	if true or (rigid_body.bola_colocada and rigid_body2.bola_colocada and soporte_gancho.gancho_colocado):

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
		# Reproducir sonido
		var sound = preload("res://sonidos/error.ogg")
		var player = AudioStreamPlayer.new()
		player.stream = sound
		add_child(player)
		player.play()
		
		# Reproducir animacion
		anim_player.play("palanca_no_giro")
		
		await player.finished
		player.queue_free()

# Funcion que se llamara desde el AnimationPlayer
func emit_activation_signal():
	emit_signal("palanca_activada")
