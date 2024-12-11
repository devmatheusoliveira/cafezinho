extends Node3D
@onready var path = $Path3D/PathFollow3D

@onready var globals_var = get_node("/root/Globals")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
	
func _physics_process(delta: float) -> void:
	if(globals_var.isMovingPersonagem):
		path.progress += delta * 4
		pass
		
		
