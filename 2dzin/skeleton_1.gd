extends CharacterBody3D

@onready var nav_agent = $NavigationAgent3D
@onready var animator = $"Skeleton_Minion/AnimationPlayer"

var SPEED = 3.0
var ROTATION_WEIGHT = 1.2

func _physics_process(delta):
	
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_direction = (next_location - current_location).normalized()
	
	if nav_agent.is_target_reachable():
		velocity = new_direction * SPEED
		
		
		var desired_rotation_y = atan2(nav_agent.target_position.x, nav_agent.target_position.z)
		rotation.y = lerp_angle(rotation.y, desired_rotation_y, ROTATION_WEIGHT)
		
		#rotation.y = desired_rotation_y
		move_and_slide()
		#look_at(-nav_agent.target_position, Vector3(0,1,0))
		animator.play("Running_A")
	else:
		animator.play("Idle")

func update_target_position(target_location):
	nav_agent.set_target_position(target_location)
