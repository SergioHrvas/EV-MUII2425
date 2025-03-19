extends Node3D  # Este script iría en CameraPivot

@export var rotation_speed: float = 90.0  # Velocidad en grados por segundo
@export var sup_tilt: float = -70.0  # Límite superior de inclinación
@export var inf_tilt: float = 70.0   # Límite inferior de inclinación

@onready var camera_pitch = $CameraPitch  # Nodo que controla la inclinación

func _ready():
	#Ponemos el origen en el padre (para que funcione si se arrastra de un padre a otro)
	global_transform.origin = get_parent().global_transform.origin
		
func _process(delta):
	# Rotación horizontal (sobre CameraPivot)
	if Input.is_action_pressed("Camara derecha global"):
		rotate_y(deg_to_rad(rotation_speed * delta))

	if Input.is_action_pressed("Camara izquierda global"):
		rotate_y(-deg_to_rad(rotation_speed * delta))

	# Rotación vertical (sobre CameraPitch)
	if Input.is_action_pressed("Camara arriba global"):
		camera_pitch.rotate_x(-deg_to_rad(rotation_speed * delta))
	
	if Input.is_action_pressed("Camara abajo global"):
		camera_pitch.rotate_x(deg_to_rad(rotation_speed * delta))

	# Aplicar los límites de inclinación
	camera_pitch.rotation_degrees.x = clamp(camera_pitch.rotation_degrees.x, sup_tilt, inf_tilt)
