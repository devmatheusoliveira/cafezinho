extends SpringArm3D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.y -= event.screen_relative.x * 0.005
		rotation.y = wrap(rotation.y, 0.0, TAU)

func _process(delta: float) -> void:
	pass
