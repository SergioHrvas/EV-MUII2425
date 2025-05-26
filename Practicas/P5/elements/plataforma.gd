extends StaticBody3D

var bola_colocada := false
var luz: OmniLight3D = null

func _ready():
	$DetectorBola.body_entered.connect(_on_body_entered)
	$DetectorBola.body_exited.connect(_on_body_exited)
	
	luz = get_parent().get_node("OmniLight3D")

func _on_body_entered(body):
	if body.name == "Bola" and not bola_colocada:
		print("Bola detectada sobre la plataforma")
		bola_colocada = true
		if(luz != null):
			luz.light_color = "#e58218"

func _on_body_exited(body):
	if body.name == "Bola" and bola_colocada:
		print("Bola quitada")
		bola_colocada = false
		if(luz != null):
			luz.light_color = "#00c014"
