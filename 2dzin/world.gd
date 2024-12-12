extends Node3D

@onready var player = $Player
@onready var bolinha = $Path3D/PathFollow3D/Bolinha

func _physics_process(delta):
	get_tree().call_group("enemies", "update_target_position", player.global_transform.origin, bolinha.global_transform.origin)
