extends Node3D

@onready var label = $"../MarginContainer/vida_exp/Label"

#var experience_required = get_required_experience(AutoloadScript.level + 1)
#AutoloadScript.exp_total = experience_required
var experience_required

func _process(delta: float) -> void:
	experience_required = get_required_experience(AutoloadScript.level + 1)
	label.update_text(AutoloadScript.level,AutoloadScript.exp, experience_required)

func get_required_experience(level):
	return round(pow(level, 1.8) + level * 4)
	
func gain_experience(amount):
	AutoloadScript.exp_total += amount
	AutoloadScript.exp += amount
	var growth_data = []
	while AutoloadScript.exp >= experience_required:
		AutoloadScript.exp -= experience_required
		growth_data.append([experience_required, experience_required])
		level_up()
	growth_data.append([AutoloadScript.exp, experience_required])
	#emit_signal("_on_Character_experience_gained", growth_data)
	get_tree().call_group("experience_bar", "_on_Character_experience_gained",growth_data)
	

func level_up():
	AutoloadScript.level += 1
	AutoloadScript.max_hp += 100
	AutoloadScript.strength += 50
	AutoloadScript.defense += 1
	experience_required = get_required_experience(AutoloadScript.level + 1)

	#var stats = ['max_hp', 'strength', 'defense']
	#var random_stat = stats[randi() % stats.size()]
	#set(random_stat, get(random_stat) + randi() % 4)


func _on_Character_experience_gained(growth_data):
	pass
