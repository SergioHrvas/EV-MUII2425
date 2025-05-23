extends CharacterBody3D 
@export var move_distance := 4.0
@export var move_speed := 2.0

var start_position: Vector3
var target_position: Vector3
var is_moving = false
var moving_up = true

# Método para activar
func toggle_move():
	var anim_node = get_parent().get_node("AnimationPlayer")
	anim_node.play("elevacion")
