extends Node

@export var ruta_habitacion1: String = "res://elements/habitacion1.tscn"
@export var ruta_habitacion2: String = "res://elements/habitacion2.tscn"
@export var posicion_habitacion1: Vector3 = Vector3(0, 0, 0)
@export var posicion_habitacion2: Vector3 = Vector3(-29.327, 31.349, 0)


var habitacion1: Node = null
var habitacion2: Node = null
var pasillo: Node = null
var posiciones_iniciales := {}
var estado_habitacion1 = {}

var palanca: StaticBody3D = null
var plataforma_real: AnimatableBody3D = null

var contador_area_1: int = 0
var contador_area_2: int = 0

	
func _ready():
	palanca = $Habitacion1/Palanca/StaticBody3D
	plataforma_real = $Pasillo/Ascensor/Plataforma
	
	palanca.connect("palanca_activada", Callable(plataforma_real, "toggle_move"))

	pasillo = $Pasillo
	habitacion1 = $Habitacion1
	habitacion2 = $Habitacion2

	if habitacion1:
		posiciones_iniciales["habitacion1"] = habitacion1.position
	if habitacion2:
		posiciones_iniciales["habitacion2"] = habitacion2.position

	if habitacion2:
		habitacion2.queue_free()
		habitacion2 = null

func _cargar_habitacion(ruta: String, nombre: String) -> Node:
	var escena = load(ruta)
	if escena:
		var instancia = escena.instantiate()
		if nombre in posiciones_iniciales:
			instancia.position = posiciones_iniciales[nombre]
		return instancia
	return null

func _on_area_1_body_entered(body):
	if body.name == "Avatar":
		contador_area_1 += 1
		if contador_area_1 == 1:
			# Cargar habitación 1
			if !habitacion1 or !is_instance_valid(habitacion1):
				habitacion1 = _cargar_habitacion(ruta_habitacion1, "habitacion1")
				if habitacion1:
					add_child(habitacion1)
					habitacion1.global_transform = Transform3D.IDENTITY.translated(posiciones_iniciales["habitacion1"])
					
					palanca = habitacion1.get_node("Palanca/StaticBody3D")
					plataforma_real = $Pasillo/Ascensor/Plataforma
					
					var callable = Callable(plataforma_real, "toggle_move")
					if palanca.is_connected("palanca_activada", callable):
						palanca.disconnect("palanca_activada", callable)
					palanca.connect("palanca_activada", callable)

					call_deferred("_restaurar_estado_habitacion1")
			# Descargar habitación 2
			if habitacion2 and is_instance_valid(habitacion2):
				habitacion2.queue_free()
				habitacion2 = null


func _on_area_2_body_entered(body):
	if body.name == "Avatar":
		contador_area_2 += 1
		if contador_area_2 == 1:
			# Cargar habitación 2
			if !habitacion2 or !is_instance_valid(habitacion2):
				habitacion2 = _cargar_habitacion(ruta_habitacion2, "habitacion2")
				if habitacion2:
					add_child(habitacion2)
					habitacion2.global_transform = Transform3D.IDENTITY.translated(posiciones_iniciales["habitacion2"])
			
			# Descargar habitación 1
			if habitacion1 and is_instance_valid(habitacion1):
				# Obtener Bola1 sin importar dónde esté
				var bola1 = get_tree().get_nodes_in_group("bola1")[0]
				var rb1 = bola1.get_node("Bola")
				rb1.freeze = true
				estado_habitacion1["pos_bola1"] = rb1.global_transform.origin
				rb1.freeze = false

				var bola2 = get_tree().get_nodes_in_group("bola2")[0]
				var rb2 = bola2.get_node("Bola")
				rb2.freeze = true
				estado_habitacion1["pos_bola2"] = rb2.global_transform.origin
				rb2.freeze = false
				
				print(estado_habitacion1["pos_bola1"])
				print(estado_habitacion1["pos_bola2"])

				habitacion1.queue_free()
				habitacion1 = null

func _on_area_1_body_exited(body):
	if body.name == "Avatar":
		contador_area_1 -= 1
		if contador_area_1 < 0:
			contador_area_1 = 0

func _on_area_2_body_exited(body):
	if body.name == "Avatar":
		contador_area_2 -= 1
		if contador_area_2 < 0:
			contador_area_2 = 0
			
			

func _restaurar_estado_habitacion1():
	if habitacion1:
		if estado_habitacion1.has("pos_bola1"):
			var bola1 = habitacion1.get_node("Bola1")
			var rb1 = bola1.get_node("Bola")  # Aquí está el RigidBody3D
			if rb1:
				rb1.freeze = true
				rb1.global_transform.origin = estado_habitacion1["pos_bola1"]
				rb1.freeze = false
				print("Restaurando bola1 en ", rb1.global_transform.origin)
		
		if estado_habitacion1.has("pos_bola2"):
			var bola2 = habitacion1.get_node("Bola2")
			var rb2 = bola2.get_node("Bola")
			if rb2:
				rb2.freeze = true
				rb2.global_transform.origin = estado_habitacion1["pos_bola2"]
				rb2.freeze = false
				print("Restaurando bola2 en ", rb2.global_transform.origin)
