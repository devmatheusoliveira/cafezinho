extends Node3D
#signal experience_gained(growth_data)

# CHARACTER STATS
@export var max_hp: int  = 12
@export var strength: int = 8
@export var defense: int = 8

# LEVELING SYSTEM
@export var level: int = 1

var experience = 0
var experience_total = 0
var experience_required = get_required_experience(level + 1)

func get_required_experience(level):
	return round(pow(level, 1.8) + level * 4)
	
func gain_experience(amount):
	experience_total += amount
	experience += amount
	var growth_data = []
	while experience >= experience_required:
		experience -= experience_required
		growth_data.append([experience_required, experience_required])
		level_up()
	growth_data.append([experience, experience_required])
	#emit_signal("_on_Character_experience_gained", growth_data)
	get_tree().call_group("experience_bar", "_on_Character_experience_gained",growth_data)
	

func level_up():
	level += 1
	experience_required = get_required_experience(level + 1)

	var stats = ['max_hp', 'strength', 'defense']
	var random_stat = stats[randi() % stats.size()]
	set(random_stat, get(random_stat) + randi() % 4)


func _on_Character_experience_gained(growth_data):
	pass
