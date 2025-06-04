extends CharacterBody3D

# Definimos las variables
@export var speed := 5.0
@export var jump_velocity := 5.0
@export var mouse_sensitivity := 0.002
@onready var ray = $Pivot/Pitch/Camera3D/RayCast3D

var gravity := 9.8
var inventario: Array = [null, null, null]
var indice_actual := 0

var objeto_agarrado: RigidBody3D = null

var grab_distance := 2.0  # Distancia a la que se agarra el objeto
# Definimos offset en local (X = derecha, Y = abajo, Z = hacia adelante negativo)
var offset_local := Vector3(0.5, -0.5, -grab_distance)

@onready var inventario_ui = get_parent().get_node("HUD/Inventario")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
# Funcion para manejar entradas
func _unhandled_input(event):
	# Movimiento del raton
	if (event is InputEventMouseMotion) and (Input.mouse_mode != Input.MOUSE_MODE_VISIBLE):
		$Pivot.rotate_y(-event.relative.x * mouse_sensitivity)
		$Pivot/Pitch.rotate_x(-event.relative.y * mouse_sensitivity)
		$Pivot/Pitch.rotation.x = clamp($Pivot/Pitch.rotation.x, deg_to_rad(-89), deg_to_rad(89))
	
	# Seleccion de objetos en el inventarios
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

	# Velocidad
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
	  
	# Si se pulsa E (interactuar)
	if Input.is_action_just_pressed("interactuar"):
		# Si hay un objeto agarrado, lo soltamos
		if objeto_agarrado:
			soltar_objeto()
		# Si no, si esta colisionando el rayo con un objeto
		elif(ray.is_colliding()):
				
				var obj = ray.get_collider()
				if obj.has_method("activar"): # Llamamos al metodo activar si lo tiene
					obj.activar()
				else: # Lo intentamos agarrar si no
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


# Funcion para agarrar objeto
func intentar_agarrar():
	# Si el rayo esta colisionando con algun objeto
	if ray.is_colliding():
		# Obtenemos el objeto con el que colisiona
		var collider = ray.get_collider()
		# Si el objeto con el que colisiona es RigidBody y del grupo csogible
		if collider is RigidBody3D and collider.is_in_group("cogible"):
			# Buscar un espacio libre en el inventario
			for i in range(3):
				if inventario[i] == null:
					if(collider.name.begins_with("Gancho")):
						collider.rotation_degrees.y = rotation_degrees.y
						
					# Actualizamos el inventario
					inventario[i] = collider
					inventario_ui.actualizar_inventario(inventario)
						
					# Congelamos y ocultamos el collider
					collider.visible = false
					collider.freeze = true
					
					collider.collision_layer = 0
					collider.collision_mask = 0
					
					return
					
					
# Funcion para soltar objeto
func soltar_objeto():
	if objeto_agarrado:
		# Restauramos colisiones
		objeto_agarrado.collision_layer = 1
		objeto_agarrado.collision_mask = 1
		objeto_agarrado.freeze = false
		
		# Si es el gancho, lo giramos para que siempre se suelte con el asa para el frente y
		# sea mas facil colocarlo
		if(objeto_agarrado.name.begins_with("Gancho")):
			objeto_agarrado.rotation_degrees = $Pivot.rotation_degrees + Vector3(0, -90, 0) # Solo eje Y
		
		# Impulso y direccion del objeto soltado
		var cam = $Pivot/Pitch/Camera3D
		var forward = -cam.global_transform.basis.z.normalized()
		var impulso = forward * 7.0 + velocity * 0.5

		objeto_agarrado.apply_central_impulse(impulso)

		# Quitar del inventario
		inventario[indice_actual] = null
		objeto_agarrado = null
		
		inventario_ui.actualizar_inventario(inventario)

# Funcion para seleccionar un objeto
func seleccionar_objeto(indice: int):
	# Si el indice no es correcto
	if indice < 0 or indice >= inventario.size():
		return
		
	# Si hay un objeto en ese indice del inventario
	if inventario[indice] != null:
		
		# Si hay objeto agarrado y el indice no es el que ya esta seleccioando
		if objeto_agarrado != null and indice != indice_actual:
			guardar_objeto()
		
		# Actualizamos objeto_agarrado
		objeto_agarrado = inventario[indice]
		objeto_agarrado.visible = true
		objeto_agarrado.freeze = true
		indice_actual = indice
		inventario_ui.marcar(indice_actual)
		
# Funcion para guardar un objeto
func guardar_objeto():
	# Si objeto_agarrado existe
	if objeto_agarrado:
		objeto_agarrado.visible = false # lo ponemos invisible
		objeto_agarrado.freeze = true # lo congelamos
		objeto_agarrado = null # quitamos objeto_agarrado
		
# Señal de cambio de camara
func _on_test_activar_avatar() -> void:
	$Pivot/Pitch/Camera3D.current = true
