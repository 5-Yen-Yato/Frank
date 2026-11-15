extends Button

@onready var menu: VBoxContainer = $".."
@onready var options: Panel = $"../../../Options"



func _on_pressed() -> void:
	menu.visible = false
	options.visible = true
