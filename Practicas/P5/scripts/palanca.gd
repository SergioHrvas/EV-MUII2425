extends Node3D

signal palanca_activada

func activar():
	print(">>> activar llamado")
	emit_signal("palanca_activada")
	print(">>> señal emitida")
