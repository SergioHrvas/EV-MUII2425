extends StaticBody3D

signal palanca_activada

func activar():
	emit_signal("palanca_activada")
	print(">>> señal emitida")
