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
		
"""
func _process(delta):
	if($Pitch/Camera3D.current == true):
		# Movimiento con teclas WASD
		var input_dir = Vector3.ZERO
		if Input.is_action_pressed("delante"):
			input_dir.z -= 1
		if Input.is_action_pressed("atras"):
			input_dir.z += 1
		if Input.is_action_pressed("izquierda"):
			input_dir.x -= 1
		if Input.is_action_pressed("derecha"):
			input_dir.x += 1
		input_dir = input_dir.normalized()
		translate_object_local(input_dir * delta * 8.0)  # Velocidad: 5 unidades/seg
"""
