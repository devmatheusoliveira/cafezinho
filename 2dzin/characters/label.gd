extends Label


func update_text(level, experience, required_exp):
	text = """Level: %s
			Experience: %s
			Required Xp: %s
			""" % [level, experience, required_exp]
