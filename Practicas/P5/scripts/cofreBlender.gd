extends StaticBody3D

func activar():
		get_parent().get_parent().get_node("AnimationPlayer").play("Scene")
