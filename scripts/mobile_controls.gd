extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.





func _on_touch_screen_button_pressed() -> void:
	SignalBus.mobile_touch_left.emit() # Replace with function body.
