extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func derrotado():
	get_tree().change_scene_to_file("res://menus/start/main_menu.tscn")
	queue_free()
	pass
