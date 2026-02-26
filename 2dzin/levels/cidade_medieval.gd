extends Node3D

@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass # Replace with function body.

func ChangeSceneBoss():
	var TheRoot = get_node("/root")
	var ThisScene = get_node("/root/CidadeMedieval")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	AutoloadScript.previous_scene = ThisScene
	var NextScene = load("res://fight_scenes/vs_skeleton_boss.tscn")
	NextScene = NextScene.instantiate()
	TheRoot.add_child(NextScene)
	
	TheRoot.remove_child(ThisScene)
	pass
	
func ChangeScene():
	var TheRoot = get_node("/root")
	var ThisScene = get_node("/root/CidadeMedieval")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
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
	if player:
		get_tree().call_group("boss", "initbatlle", player.global_transform.origin)
	escape()
	pass
	
func escape() -> void:
	if Input.is_action_just_pressed("esc"):
		get_tree().change_scene_to_file("res://menus/start/main_menu.tscn")
		pass
