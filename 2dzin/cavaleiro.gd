extends CharacterBody3D


const SPEED = 5.0
const RUN_SPEED = 7.0
const JUMP_VELOCITY = 4.5
@onready var animation_tree = $AnimationTree
@onready var model = $Knight
@onready var label = $CanvasLayer/VBoxContainer/Label
@onready var life_bar = $InitialHUD/MarginContainer/vida_exp/Life

func _physics_process(delta: float) -> void:
	label.update_text(AutoloadScript.level,AutoloadScript.exp, AutoloadScript.exp)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		animation_tree.set("parameters/Transition/transition_request","andar")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		animation_tree.set("parameters/Transition/transition_request", "parado")

	#if(input_dir == Vector2.ZERO):
		#animation_tree.set("parameters/Transition/transition_request", "andar")
	#else:
		#animation_tree.set("parameters/Transition/transition_request", "andar")
	update_life_bar()
	move_and_slide()

@export var sensitivity: float = 0.005  # Ajustável no editor
@export var min_vertical_angle: float = -45  # Ângulo mínimo em graus
@export var max_vertical_angle: float = 90   # Ângulo máximo em graus

func _input(event):
	if event is InputEventMouseMotion:
		# Rotação horizontal (y)
		rotation.y -= event.relative.x * sensitivity

		# Rotação vertical (x) com clamp
		$CameraPivot.rotation.x -= event.relative.y * sensitivity
		$CameraPivot.rotation.x = clamp($CameraPivot.rotation.x, deg_to_rad(min_vertical_angle), deg_to_rad(max_vertical_angle))

func update_life_bar():
	life_bar.set_value(AutoloadScript.current_life)
	life_bar.max_value = AutoloadScript.max_hp
