extends Node3D

@onready var player_level = $Player/Node3D
@onready var player = $Player
@onready var bolinha = $Path3D/PathFollow3D/Bolinha
@onready var label = $CanvasLayer/VBoxContainer/Label

func _physics_process(_delta):
	pass
