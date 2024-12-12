extends CharacterBody3D

@onready var animator = $"Skeleton_Minion/AnimationPlayer"
@onready var nav_agent = $NavigationAgent3D
@onready var path_follow = get_parent()

var SPEED = 3.0
var AWAIT_TIME = 4.0
var LOCATION = 1 # Se location = 0 animação é de seguir o player, se location = 1 animação de andar


func _physics_process(delta):
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_direction = (next_location - current_location).normalized()
	
	if nav_agent.is_target_reachable():
		velocity = new_direction * SPEED
		
		#var desired_rotation_y = atan2(nav_agent.target_position.x, nav_agent.target_position.z)
		#rotation.y = desired_rotation_y
		
		#rotation.y = desired_rotation_y
		if not current_location.is_equal_approx(nav_agent.target_position):
			# Faz o inimigo olhar para o alvo se as posições não forem iguais
			look_at(nav_agent.target_position, Vector3.UP)
		rotation.x = 0
		rotation.z = 0
		move_and_slide()
		if(LOCATION == 0):
			animator.play("Running_A")
		else:
			animator.play("Walking_A")
	else:
		rotation.x = 0
		rotation.z = 0
		#animator.play("Idle")
		

func update_target_position(target_location, bolinha_location):
	await get_tree().physics_frame
	nav_agent.set_target_position(target_location)
	if nav_agent.is_target_reachable():
		LOCATION = 0
		SPEED = 3.0
		pass
	else:
		SPEED = 2.0
		LOCATION = 1
		nav_agent.set_target_position(bolinha_location)
