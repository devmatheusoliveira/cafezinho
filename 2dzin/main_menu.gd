extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file('') #String contendo a cena
	pass

func _on_opcoes_pressed() -> void:
	#var options = load('res://Levels/control.tscn').instance() #String contendo a cena de opções
	get_tree().change_scene_to_file('res://Levels/control.tscn')
	pass 

func _on_sair_pressed() -> void:
	get_tree().quit()
	pass
