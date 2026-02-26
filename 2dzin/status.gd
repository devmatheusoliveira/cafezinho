extends Label

@onready var status_label = $InitialHUD/Status/label/Status

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_hud()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_hud()

func update_hud():
	text = "HP: " + str(AutoloadScript.get_hp()) + "/" + str(AutoloadScript.get_hp_total()) + "\n"
	text += "Força: " + str(AutoloadScript.get_strength()) + "\n" + "Defesa: " + str(AutoloadScript.get_defense()) 
