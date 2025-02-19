extends CharacterBody3D

@onready var animation_tree = $AnimationTree
var life = 1
var turn: bool = false; # Define se é o turno do inimigo
const base_damage = 200
var morreu = 0;

func _ready() -> void:
	randomize()
	pass

func _physics_process(delta: float) -> void:
	var state_machine = animation_tree.get("parameters/playback") as AnimationNodeStateMachinePlayback
	var current_animation = state_machine.get_current_node()
	
	if life <= 0:
		animation_tree.set("parameters/conditions/died", true)
		get_tree().call_group("player","victory")
		if(morreu == 0):
			$"../Knight/InitialHUD/Node3D".gain_experience(15)
			morreu = 1
	if(current_animation != "Idle"):
		animation_handler()
	elif (turn == true && current_animation == "Idle"):
		attack()
		turn = false
	pass

func attack():
	
	animation_tree.set("parameters/conditions/attack", true)
	pass

func attack_trigger() -> void:
	get_tree().call_group("player","receive_attack", base_damage)
	pass

func receive_attack(damage):
	var random = randi() % 20
	if(random <= 14):
		animation_tree.set("parameters/conditions/attacked", true)
		life -= damage
	else:
		animation_tree.set("parameters/conditions/dodge", true)
	pass

func animation_handler():
	animation_tree.set("parameters/conditions/attacked", false)
	animation_tree.set("parameters/conditions/attack", false)
	animation_tree.set("parameters/conditions/dodge", false)
	pass

func change_turn():
	turn = true

func pass_turn():
	get_tree().call_group("player","change_turn")
