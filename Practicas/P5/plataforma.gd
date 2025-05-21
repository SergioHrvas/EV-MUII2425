extends CharacterBody3D 
@export var move_distance := 4.0
@export var move_speed := 2.0

var start_position: Vector3
var target_position: Vector3
var is_moving = false
var moving_up = true

func _ready():
	start_position = global_transform.origin
	target_position = start_position + Vector3(0, move_distance, 0)

func _physics_process(delta):
	if is_moving:
		var direction = (target_position - global_transform.origin).normalized()
		var motion = direction * move_speed * delta
		var remaining = global_transform.origin.distance_to(target_position)

		if motion.length() > remaining:
			motion = target_position - global_transform.origin
			is_moving = false

		# CharacterBody3D requiere usar su propiedad velocity
		velocity = motion / delta
		move_and_slide()

# Método para activar
func toggle_move():
	is_moving = true
	if moving_up:
		target_position = start_position + Vector3(0, move_distance, 0)
	else:
		target_position = start_position
	moving_up = !moving_up
