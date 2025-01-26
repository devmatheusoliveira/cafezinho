extends Node3D

@onready var player_level = $Player/Node3D
@onready var player = $Player
@onready var bolinha = $Path3D/PathFollow3D/Bolinha
@onready var label = $CanvasLayer/VBoxContainer/Label

func _physics_process(_delta):
	if Input.is_action_just_pressed("space"):
		player_level.gain_experience(15)
	get_tree().call_group("enemies", "update_target_position", player.global_transform.origin, bolinha.global_transform.origin)
	label.update_text(player_level.level, player_level.experience, player_level.experience_required)
