@tool
extends TextureProgressBar

var progress_bg_texture: Texture  # Para o fundo da ProgressBar
var progress_fill_texture: Texture  # Para o preenchimento da ProgressBar

#func _ready() -> void:
	#
	#
	#value = AutoloadScript.exp
	#max_value = AutoloadScript.exp_total


func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return  # Evita chamar o código no editor
	value = AutoloadScript.get_exp()
	max_value = AutoloadScript.get_exp_total()

# Inicializa o valor de progresso
func initialize(current, maximum):
	value = AutoloadScript.get_exp()
	max_value = AutoloadScript.get_exp_total()  # Ajusta o valor máximo
	
	# Define as texturas da barra de progresso
	self.texture_progress = progress_fill_texture  # Define a textura de preenchimento
	self.texture_bg = progress_bg_texture  # Define a textura de fundo

# Quando a experiência do personagem é ganha
func _on_Character_experience_gained(growth_data):
	for line in growth_data:
		var target_exp = line[0]
		var max_exp = line[1]
		max_value = max_exp  # Atualiza o valor máximo
		
		# Atualiza a ProgressBar animadamente
		await animate_value(target_exp)  # Usando `await` para aguardar o término da animação
		
		# Verifica se a experiência atingiu o valor máximo, e reinicia a barra de progresso
		if abs(max_value - value) < 0.01:
			value = 0.0

# Função para animar o valor da ProgressBar
func animate_value(target, tween_duration=0.5):
	# Cria o tween para animar o valor da ProgressBar
	var tween = create_tween()
	if tween == null:
		tween = Tween.new()
		add_child(tween)
		
	# Configura a animação do valor da ProgressBar
	tween.tween_property(self, "value", target, tween_duration,).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
	# Aguardando o fim da animação
	await tween.finished
