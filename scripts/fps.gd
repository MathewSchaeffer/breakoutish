extends Control

@onready var label: Label = $Label

func _ready() -> void:
	SignalBus.fps_toggle.connect(toggle_state)

# Called when the node enters the scene tree for the first time.
func _process(_delta: float) -> void:
	if !self.visible:
		return
	else:
		label.text = str(Engine.get_frames_per_second())
		
func toggle_state() -> void:
	if self.visible:
		self.hide()
	else:
		self.show()
