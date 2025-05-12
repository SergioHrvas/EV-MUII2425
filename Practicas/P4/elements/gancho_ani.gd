extends Node3D


func _ready() -> void:
	pass


func _process(delta: float):
	if Input.is_action_pressed("espacio"):
		$AnimationPlayer.play("Curva_Bezier_001_acción_001")
	pass
