extends Node3D


func _ready() -> void:
	pass


func _process(delta: float):
	if Input.is_action_just_pressed("espacio"):
		$AnimationPlayer.play("MartilloTapaderaAccion")
	
	if Input.is_action_just_released("espacio"):
		$AnimationPlayer.pause()  # Usamos stop() en lugar de pause()
