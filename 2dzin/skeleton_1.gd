extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@onready var animator = $"Skeleton_Minion/AnimationPlayer"
@onready var globals_var = get_node("/root/Globals")

var SPEED = 3.0
var ROTATION_WEIGHT = 1.2


func _physics_process(delta):
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_direction = (next_location - current_location).normalized()
	
	if nav_agent.is_target_reachable():
		#velocity = new_direction * SPEED
		#if not current_location.is_equal_approx(nav_agent.target_position):
			## Faz o inimigo olhar para o alvo se as posições não forem iguais
			#look_at(nav_agent.target_position, Vector3.UP)
		#rotation.x = 0
		#rotation.z = 0
		#move_and_slide()
		animator.play("Running_A")
		globals_var.setMoverPersonagem(false)
	else:
		globals_var.setMoverPersonagem(true)
		animator.play("Walking_A")


func update_target_position(target_location):
	nav_agent.set_target_position(target_location)
	
