extends StaticBody3D

signal palanca_activada

var anim_player: AnimationPlayer

func _ready():
	anim_player = get_parent().get_node("AnimationPlayer")


func activar():
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

# Esta función será llamada por el AnimationPlayer
func emit_activation_signal():
	emit_signal("palanca_activada")
