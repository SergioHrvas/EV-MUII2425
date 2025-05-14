extends Node3D

var mouse_captured = true
var velocity = 10.0

@export var dpi = 200.0 # Sensibilidad

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

@export var pivot_limit_left: float = -45.0  # Límite izquierdo en grados
@export var pivot_limit_right: float = 45.0  # Límite derecho en grados
var current_pivot: float = 0.0  

func _input(event):
	if event is InputEventMouseMotion and mouse_captured and ($Pitch/Vigilante.current == true):
		# Rotación horizontal (pivot) con límites
		var pivot_rotation = -event.relative.x / dpi
		current_pivot += pivot_rotation
		current_pivot = clamp(current_pivot, deg_to_rad(pivot_limit_left), deg_to_rad(pivot_limit_right))
		rotation.y = current_pivot
		
		# Rotación vertical (Pitch, limitada)
		$Pitch.rotate_x(-event.relative.y / dpi)
		$Pitch.rotation.x = clamp($Pitch.rotation.x, -1.2, 1.2)

	# Zoom con rueda del ratón
	if event is InputEventMouseButton and $Pitch/Vigilante.current == true:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			$Pitch/Vigilante.fov = clamp($Pitch/Vigilante.fov - 5, 10, 70)  # Acercar zoom
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			$Pitch/Vigilante.fov = clamp($Pitch/Vigilante.fov + 5, 10, 70)  # Alejar zoom


	if event.is_action_pressed("ui_cancel"):  # Tecla Escape
		get_tree().quit()  # Cerrar juego
		
func _on_test_activar_vigilante() -> void:
	$Pitch/Vigilante.current = true
