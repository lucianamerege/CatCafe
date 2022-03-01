extends TextureButton

func _ready():
	print("eu sou o godot")

func _on_NovoJogo_button_down():
	get_tree().change_scene("res://Scenes/Level/Cafe.tscn")

