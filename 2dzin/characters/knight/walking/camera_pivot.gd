extends Node3D

@export var sensitivity: float = 0.005  # Ajustável no editor
@export var min_vertical_angle: float = -45  # Ângulo mínimo em graus
@export var max_vertical_angle: float = 90   # Ângulo máximo em graus
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if event is InputEventMouseMotion:
		# Rotação horizontal (y)
		rotation.y -= event.relative.x * sensitivity

		# Rotação vertical (x) com clamp
		rotation.x -= event.relative.y * sensitivity
		rotation.x = clamp(rotation.x, deg_to_rad(min_vertical_angle), deg_to_rad(max_vertical_angle))
