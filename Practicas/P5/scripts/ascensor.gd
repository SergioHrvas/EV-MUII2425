extends AnimatableBody3D

@export var delay_before_descend := 5.0

var up = false
var player_on_elevator = false
var time_on_elevator = 0.0
var esperando_subida := false

func _ready():
	var area = $Area3D
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)

func _process(delta):
	if player_on_elevator and up:
		time_on_elevator += delta
		if time_on_elevator >= delay_before_descend:
			toggle_move()  # baja
			time_on_elevator = 0.0  # reset


func toggle_move():
	var anim_node = get_parent().get_node("AnimationPlayer")
	print("PRUEBA")
	if up:
		anim_node.play("bajada")
		up = false
	else:
		anim_node.play("subida")
		esperando_subida = true
		# Conectamos la señal temporalmente
		if not anim_node.is_connected("animation_finished", Callable(self, "_on_animacion_finalizada")):
			anim_node.connect("animation_finished", Callable(self, "_on_animacion_finalizada"))

func _on_animacion_finalizada(nombre_anim):
	if nombre_anim == "subida" and esperando_subida:
		up = true
		esperando_subida = false
		
		# Desconectar para evitar llamadas innecesarias
		var anim_node = get_parent().get_node("AnimationPlayer")
		if anim_node.is_connected("animation_finished", Callable(self, "_on_animacion_finalizada")):
			anim_node.disconnect("animation_finished", Callable(self, "_on_animacion_finalizada"))

func _on_body_entered(body):
	print(body.name)
	if body.name == "Avatar": 
		player_on_elevator = true
		time_on_elevator = 0.0  # reinicia el contador al entrar

func _on_body_exited(body):
	if body.name == "Avatar":
		player_on_elevator = false
		time_on_elevator = 0.0  # reinicia el contador al salir
