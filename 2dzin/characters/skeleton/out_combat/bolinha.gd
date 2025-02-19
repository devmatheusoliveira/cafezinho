extends CharacterBody3D

@onready var path_follow = get_parent()

func _physics_process(delta: float) -> void:
	path_follow.progress += delta*10
