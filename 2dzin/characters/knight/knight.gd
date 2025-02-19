extends CharacterBody3D

@onready var animation_tree = $"AnimationTree"
@onready var anim_play = $"Knight/AnimationPlayer"
@onready var life_bar = $InitialHUD/MarginContainer/vida_exp/Life
@onready var hbox = $InitialHUD/HBoxContainer
@onready var derrota = $InitialHUD/Derrota
@onready var sucess = $InitialHUD/Sucesso
@onready var vitoria = $InitialHUD/Venceu
var damage = 400
var life = 1200
var defesa: bool = false
var counter: bool = false
var pontos_defesa = 10
var turn = true
var agility = 1;

func _ready() -> void:
	randomize()

func _physics_process(delta: float) -> void:
	var state_machine = animation_tree.get("parameters/playback") as AnimationNodeStateMachinePlayback
	var current_animation = state_machine.get_current_node()
	life_bar.set_value_no_signal(life)
	if life <= 0:
		animation_tree.set("parameters/conditions/died", true)
		derrota.visible = true
		hbox.visible = false
	elif(current_animation != "Idle"):
		animation_handler(current_animation)
	
	pass

func receive_attack(damage):
	if defesa:
		defence_handler(damage)
		defesa = false
	else:
		animation_tree.set("parameters/conditions/hit", true)
		life -= damage

func _on_atacar_pressed() -> void:
	hbox.visible = false
	if turn:
		animation_tree.set("parameters/conditions/attack", true)
		turn = false
	pass # Replace with function body.

func _on_attack_trigger() -> void:
	get_tree().call_group("enemies","receive_attack", damage)
	pass

func _on_counter_attack_trigger() -> void:
	get_tree().call_group("enemies","receive_attack", damage)
	animation_tree.set("parameters/conditions/attack", false)

func _on_fugir_pressed() -> void:
	var random = randi() % 10
	hbox.visible = false
	if(random + agility > 5):
		sucess.visible = true
	else:
		get_tree().call_group("enemies","change_turn")
	pass # Replace with function body.

func animation_handler(current_animation):
	if(current_animation == "Block"):
		animation_tree.set("parameters/conditions/defend", false)
	if(current_animation == "Attack"):
		animation_tree.set("parameters/conditions/attack", false)
	animation_tree.set("parameters/conditions/hit", false)
	pass


func _on_defender_pressed() -> void:
	hbox.visible = false
	if turn:
		defesa = true
		turn = false
		get_tree().call_group("enemies","change_turn")
	pass # Replace with function body.

func defence_handler(damage):
	var random = randi() % pontos_defesa
	if(random < 3):
		animation_tree.set("parameters/conditions/hit", true)
		life -= damage
	elif(random < 6):
		animation_tree.set("parameters/conditions/defend", true)
		life -= damage/2
	else:
		animation_tree.set("parameters/conditions/defend", true)
		animation_tree.set("parameters/conditions/attack", true)
		counter = true
	pass

func change_turn():
	turn = true

func pass_turn():
	get_tree().call_group("enemies","change_turn")
	pass

func show_combat_options():
	hbox.visible = true

func animation_counter_handler():
	if !counter:
		hbox.visible = true
		counter = false

func victory():
	vitoria.visible = true
	pass


func _on_prosseguir_pressed() -> void:
	var TheRoot = get_node('/root')
	var ThisScene = get_node('/root/Node3D')
	
	TheRoot.remove_child(ThisScene)
	ThisScene.call_deferred("free")
	
	var NextScene = AutoloadScript.previous_scene
	TheRoot.add_child(NextScene)
	pass # Replace with function body.
