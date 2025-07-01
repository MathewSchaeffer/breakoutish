extends Node2D

@onready var buttons: Node = $Buttons
@onready var label: Label = $Label
const SETTINGS_MENU: PackedScene = preload("res://template/settings_menu.tscn")


func _ready() -> void:
	center_ui_elements()
	SignalBus.settings_menu_open.connect(settings_menu_opened)
	SignalBus.settings_menu_close.connect(settings_menu_closed)
	
	
func center_ui_elements() -> void:
	var screenSize: Vector2 = Vector2()
	var buttonArray: Array = buttons.get_children()
	screenSize = get_viewport_rect().size
	label.position.x = (screenSize.x / 2) - (label.size.x / 2)
	for i: Button in buttonArray:
		i.position.x = (screenSize.x / 2) - (i.size.x / 2)
	
			
func settings_menu_opened() -> void:
		var buttonArray: Array = get_tree().get_nodes_in_group("start_buttons")
		for i: Button in buttonArray:
			i.disabled = true
		print("menu opened")

			
func settings_menu_closed() -> void:
		var buttonArray: Array = get_tree().get_nodes_in_group("start_buttons")
		for i: Button in buttonArray:
			i.disabled = false
		print("menu closed")
		

func _on_start_pressed() -> void:
	if Global.settingsMenuOpen == true:
		return
	else:
		SceneManager.change_scene(SceneManager.LEVEL_1, "fade_to_black", 2) 


func _on_settings_pressed() -> void:
	var screenSize: Vector2 = get_viewport_rect().size
	if Global.settingsMenuOpen == true:
		return
	else:
		var createSettings: CanvasLayer =  SETTINGS_MENU.instantiate()
		createSettings.offset = screenSize / 2
		add_child(createSettings)
		SignalBus.settings_menu_open.emit()


func _on_exit_pressed() -> void:
	if Global.settingsMenuOpen == true:
		return
	else:
		SceneManager.fade_only()
		await get_tree().create_timer(1.5).timeout
		get_tree().quit()
