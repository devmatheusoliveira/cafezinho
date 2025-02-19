extends Node3D

@onready var player = $Player
@onready var bolinha = $Node3D/Path3D/PathFollow3D/Bolinha

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func ChangeScene():
	var TheRoot = get_node("/root")
	var ThisScene = get_node("/root/CidadeMedieval")
	
	AutoloadScript.previous_scene = ThisScene
	var NextScene = load("res://fight_scenes/vs_skeleton.tscn")
	NextScene = NextScene.instantiate()
	TheRoot.add_child(NextScene)
	
	TheRoot.remove_child(ThisScene)
	
	
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player:
		get_tree().call_group("enemies", "update_target_position", player.global_transform.origin)
	pass
