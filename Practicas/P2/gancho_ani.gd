extends Node3D


func _ready() -> void:
	pass


func _process(delta: float):
	if Input.is_action_pressed("ui_right"):
		$AnimationPlayer.play("Curva_Bezier_001_acción_001")
	if Input.is_action_just_released("ui_right"):
		$AnimationPlayer.pause()
	pass
