extends Control

@onready var high_score_label: Label = $HighScoreLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if Global.newHighScore == true:
		high_score_label.show()
		high_score_label.text = "NEW HIGH SCORE!!" + "\n" + str(Global.highscore)
	else:
		high_score_label.hide()
		


func _on_play_again_pressed() -> void:
	SceneManager.change_scene(SceneManager.LEVEL_1, "fade_to_black")


func _on_main_menu_pressed() -> void:
	SceneManager.change_scene(SceneManager.TITLE_SCREEN, "swipe_from_left")
