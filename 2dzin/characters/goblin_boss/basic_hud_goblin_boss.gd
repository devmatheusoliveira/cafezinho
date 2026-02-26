extends CanvasLayer
@onready var life_bar = $"MarginContainer/vida_exp/Life"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	life_bar.max_value = AutoloadScript.max_hp
	life_bar.value = AutoloadScript.current_life
	pass


func _on_atacar_pressed() -> void:
	get_tree().call_group("player","_on_atacar_pressed")
	pass # Replace with function body.


func _on_defender_pressed() -> void:
	get_tree().call_group("player","_on_defender_pressed")
	pass # Replace with function body.


func _on_prosseguir_pressed() -> void:
	get_tree().call_group("player","_on_prosseguir_pressed")
	pass # Replace with function body.


func _on_derrota_pressed() -> void:
	get_tree().call_group("world","derrotado")
	pass # Replace with function body.

func _on_vencer_pressed() -> void:
	get_tree().call_group("world", "trocarCena")
	pass # Replace with function body.
