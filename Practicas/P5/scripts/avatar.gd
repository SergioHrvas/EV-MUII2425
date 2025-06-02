extends CharacterBody3D

func _on_test_activar_avatar() -> void:
	$Pivot/Pitch/Camera3D.current = true

@export var speed := 5.0
@export var jump_velocity := 5.0
@export var mouse_sensitivity := 0.002
@onready var ray = $Pivot/Pitch/Camera3D/RayCast3D

var gravity := 9.8
var inventario: Array = [null, null, null]
var indice_actual := 0

var objeto_agarrado: RigidBody3D = null

var padre_original: Node = null
var grab_distance := 2.0  # Distancia a la que se agarra el objeto

# Offset en local (X = derecha, Y = abajo, Z = hacia adelante negativo)
var offset_local := Vector3(0.5, -0.5, -grab_distance)

@onready var inventario_ui = get_parent().get_node("HUD/Inventario")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	print(inventario_ui.name)

func _unhandled_input(event):
	if (event is InputEventMouseMotion) and (Input.mouse_mode != Input.MOUSE_MODE_VISIBLE):
		$Pivot.rotate_y(-event.relative.x * mouse_sensitivity)
		$Pivot/Pitch.rotate_x(-event.relative.y * mouse_sensitivity)
		$Pivot/Pitch.rotation.x = clamp($Pivot/Pitch.rotation.x, deg_to_rad(-89), deg_to_rad(89))
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_1: seleccionar_objeto(0)
			KEY_2: seleccionar_objeto(1)
			KEY_3: seleccionar_objeto(2)
			
func _physics_process(delta):
	var pivot_basis = $Pivot.global_transform.basis

	# Movimiento del personaje
	var direction = Vector3.ZERO
	if Input.is_action_pressed("delante"):
		direction -= pivot_basis.z
	if Input.is_action_pressed("atras"):
		direction += pivot_basis.z
	if Input.is_action_pressed("izquierda"):
		direction -= pivot_basis.x
	if Input.is_action_pressed("derecha"):
		direction += pivot_basis.x

	direction = direction.normalized()
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	# Gravedad y salto
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_velocity
	
	
	# Mover objeto agarrado
	if objeto_agarrado:
		var cam = $Pivot/Pitch/Camera3D

		# Convertimos el offset local a espacio global
		var offset_global = cam.global_transform.basis * offset_local
		var target_position = cam.global_position + offset_global

		objeto_agarrado.global_transform.origin = target_position
		objeto_agarrado.global_transform.basis = cam.global_transform.basis


	move_and_slide()
	  
	if Input.is_action_just_pressed("interactuar"):
		if objeto_agarrado:
			soltar_objeto()
		elif(ray.is_colliding()):
				var obj = ray.get_collider()
				print(obj.name)
				if obj.has_method("activar"):
					obj.activar()
				intentar_agarrar()
				
	# Empujar RigidBody3D al colisionar caminando
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider is RigidBody3D:
			var push_dir = -collision.get_normal()
			push_dir.y = 0  # No empujar hacia arriba/abajo
			push_dir = push_dir.normalized()

			var force = push_dir * speed * 0.3
			collider.apply_central_impulse(force)

func intentar_agarrar():
	if ray.is_colliding():
		var collider = ray.get_collider()
		if collider is RigidBody3D and (collider.name.begins_with("Bola") or collider.name.begins_with("Gancho")):
			# Buscar un espacio libre en el inventario
			for i in range(3):
				if inventario[i] == null:
					if(collider.name.begins_with("Gancho")):
						collider.rotation_degrees.y = 90  # Rotación fija en Y al guardar
						
					print("Guardando objeto en inventario[", i, "]")
					inventario[i] = collider
					inventario_ui.actualizar_inventario(inventario)
						
					collider.visible = false
					collider.freeze = true
					
					collider.collision_layer = 0
					collider.collision_mask = 0
					
					
					return
			print("Inventario lleno")


func soltar_objeto():
	if objeto_agarrado:
		print("Soltando pelota")

		# Restauramos colisiones (ajusta según tu configuración)
		objeto_agarrado.collision_layer = 1
		objeto_agarrado.collision_mask = 1
		objeto_agarrado.freeze = false
		
		if(objeto_agarrado.name.begins_with("Gancho")):
			objeto_agarrado.rotation_degrees = Vector3(0, 90, 0)  # Solo eje Y
		
		var cam = $Pivot/Pitch/Camera3D
		var forward = -cam.global_transform.basis.z.normalized()
		var impulso = forward * 7.0 + velocity * 0.5

		objeto_agarrado.apply_central_impulse(impulso)

		# Quitar del inventario
		inventario[indice_actual] = null
		objeto_agarrado = null
		
		inventario_ui.actualizar_inventario(inventario)

		
func seleccionar_objeto(indice: int):
	if indice < 0 or indice >= inventario.size():
		return
	if inventario[indice] != null:
		if objeto_agarrado != null and indice != indice_actual:
			guardar_objeto()
		
		objeto_agarrado = inventario[indice]
		objeto_agarrado.visible = true
		objeto_agarrado.freeze = true
		indice_actual = indice
		print("Objeto del inventario seleccionado: ", indice)


func guardar_objeto():
	if objeto_agarrado:
		objeto_agarrado.visible = false
		objeto_agarrado.freeze = true
		objeto_agarrado = null
