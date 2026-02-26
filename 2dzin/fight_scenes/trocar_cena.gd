extends Node3D


func trocarCena():
	get_tree().change_scene_to_file("res://levels/Cidade_Medieval.tscn")
	queue_free()

func derrotado():
	get_tree().change_scene_to_file("res://menus/start/main_menu.tscn")
	AutoloadScript.reset_all()
	queue_free()
	pass
