extends CharacterBody3D

@onready var animation_tree = $"AnimationTree"
@onready var anim_play = $"Knight/AnimationPlayer"
@onready var camera = $SpringArm3D
@onready var label = $CanvasLayer/VBoxContainer/Label
@onready var life_bar = $InitialHUD/MarginContainer/vida_exp/Life
@export var speed = 5
@export var fall_acceleration = 75

var target_velocity = Vector3.ZERO


func _ready():
	
	
	animation_tree.active = true
func _physics_process(delta: float) -> void:
	instanciarItens()
	update_life_bar()
	label.update_text(AutoloadScript.level,AutoloadScript.exp, AutoloadScript.exp)
	var direction = Vector3.ZERO
	var rotated_direction = Vector3.ZERO
	#Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.z += 1
	if Input.is_action_pressed( "ui_up"):
		direction.z -= 1
	else:
		pass
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		
		# Normaliza o vetor de direção
		direction = direction.normalized()
		# Obtém a rotação da câmera em radianos
		var camera_rotation = camera.rotation.y
		# Rotaciona o vetor de direção com base na rotação da câmera
		rotated_direction = direction.rotated(Vector3.UP, camera_rotation)
		# Define a velocidade do personagem
		$"Knight".basis = Basis.looking_at(-rotated_direction)
		velocity = rotated_direction * speed
	rodarAnimacao(rotated_direction)
	target_velocity.x = rotated_direction.x * speed
	target_velocity.z = rotated_direction.z * speed
	velocity = target_velocity
	move_and_slide()
	
	
func rodarAnimacao(direcao: Vector3):
	if direcao != Vector3.ZERO:
		animation_tree.set("parameters/conditions/walk", true)
		animation_tree.set("parameters/conditions/idle", false)
		return
	animation_tree.set("parameters/conditions/walk", false)
	animation_tree.set("parameters/conditions/idle", true)
	pass

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.get_parent_node_3d().name == "Cup-coffee":
		add_life(100)
		body.get_parent_node_3d().queue_free()
	pass # Replace with function body.

func add_life(value: int):
	AutoloadScript.current_life += value
	if AutoloadScript.current_life >= AutoloadScript.max_hp:
		AutoloadScript.current_life = AutoloadScript.max_hp
	life_bar.set_value(AutoloadScript.current_life)
	life_bar.max_value = AutoloadScript.max_hp
	
func update_life_bar():
	life_bar.set_value(AutoloadScript.current_life)
	life_bar.max_value = AutoloadScript.max_hp


@onready var person = $"."
func instanciarItens():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	var cenaAtual = person.get_parent()
	var cafe = load("res://itens_consumiveis/cafezinho.tscn")
	var positions_itens = [Vector3(3,0,0), Vector3(0,0,-3), Vector3(3,0,-3)]
	for position in range(AutoloadScript.itensDropados) :
		print(position)
		var instancia_do_cafe = cafe.instantiate()
		var posicao_itens = person.global_position + positions_itens[position]
		instancia_do_cafe.global_position = posicao_itens
		cenaAtual.add_child(instancia_do_cafe)
		pass
	AutoloadScript.itensDropados = 0;
	# Called when the node enters the scene tree for the first time.


func teste() -> void:
	print("venci")
