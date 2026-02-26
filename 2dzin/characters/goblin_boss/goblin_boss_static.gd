extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.

func initbatlle(player_pos: Vector3):
	var distancia = global_transform.origin.distance_to(player_pos)
	if(distancia < 1):
		get_tree().call_group("world","ChangeSceneBoss")
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
