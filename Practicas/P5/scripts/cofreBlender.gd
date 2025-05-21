extends Node3D


func _process(_delta: float):
	if Input.is_action_just_pressed("espacio"):
		$AnimationPlayer.play("Scene")
