extends CanvasLayer



var button1_clicked = false
var button4_clicked = false

func _on_button_button_up() -> void:
	$Control/Button/Cuadrado1.color = $Control/Button2/Cuadrado2.color
	button1_clicked = true
	check_buttons_clicked()  # Verificar si ambos fueron clickeados

func _on_button_4_button_up() -> void:
	$Control/Button4/Cuadrado4.color = $Control/Button2/Cuadrado2.color
	button4_clicked = true
	check_buttons_clicked()  # Verificar si ambos fueron clickeados

func check_buttons_clicked():
	if button1_clicked and button4_clicked:
		$Control.visible = false
		$Control2.visible = true
		


func _on_boton_quitar_button_up() -> void:
	get_tree().quit()  # Cierra el juego


func _on_boton_empezar_button_up() -> void:
	get_parent().get_node("Avatar").position = Vector3(-0.96,0.777,-5.43)
	get_tree().reload_current_scene()
	
