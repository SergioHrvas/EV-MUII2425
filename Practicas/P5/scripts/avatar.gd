extends Node3D

var mouse_captured = true
var velocity = 10.0

@export var sensitivity = 200.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	# Zoom con rueda del ratón
	if event is InputEventMouseButton and $Pitch/Camera3D.current == true:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			$Pitch/Camera3D.fov = clamp($Pitch/Camera3D.fov - 5, 10, 70)  # Acercar zoom
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			$Pitch/Camera3D.fov = clamp($Pitch/Camera3D.fov + 5, 10, 70)  # Alejar zoom

	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()  # Cierra el juego
