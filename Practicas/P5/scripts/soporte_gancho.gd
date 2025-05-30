extends RigidBody3D

var gancho_colocado := false

func _ready():
	$DetectorGancho.body_entered.connect(_on_body_entered)
	$DetectorGancho.body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.name == "Gancho" and not gancho_colocado:
		print("Gancho detectado sobre el soporte")
		gancho_colocado = true

func _on_body_exited(body):
	if body.name == "Gancho" and gancho_colocado:
		print("Gancho quitado")
		gancho_colocado = false
