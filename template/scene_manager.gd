extends CanvasLayer


const TITLE_SCREEN: String = "res://template/TitleScreen.tscn"
const LEVEL_1: String = "res://levels/level_1.tscn"
const LEVEL_2: String = "res://levels/level_2.tscn"
var scene_is_changing: bool = false
var simpleTransitionArray: Array = ["fade_to_black", "swipe_from_left"]
var advancedTransitionArray: Array = ["curtain_close_horizontal", "curtain_close_vertical"]
@onready var fade_rect: ColorRect = $FadeRect
@onready var anim: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	fade_rect.color = Color(0,0,0,255)
	fade_rect.position = Vector2.ZERO
	anim.play("fade_from_black")
		
		
func _process(_delta: float) -> void:
	pass

##Use this function to change scene, set a transition - "fade_to_black", "swipe_from_left", and duration multiplier (default 1)
##[br]
##res://template/transition.gd
##[br]
func change_scene(scene: String, transition: String = "none", duration: float = 1.0) -> void:
	anim.speed_scale *= duration
	if !scene_is_changing:
		if transition == "none":
			get_tree().call_deferred("change_scene_to_file", scene)
		elif simpleTransitionArray.has(transition):
			run_change_scene(transition, scene)
		elif advancedTransitionArray.has(transition):
			push_error("Advanced Transition Called! I like your enthusiasm, however they haven't been coded in yet! Whoops!")
		else:
			push_error("Unknown transition " + "( " + transition +  " )" + " called. If no transition is needed, arg String: 'none' is required. Refer to change_scene() hint at list of available transitions")
	else: 
		return
	anim.speed_scale = 1
	
	
func run_change_scene(anim_name: String, scene: String) -> void:
		scene_is_changing = true
		anim.play(anim_name)
		await anim.animation_finished
		get_tree().call_deferred("change_scene_to_file", scene)
		anim.play_backwards(anim_name)
		await anim.animation_finished
		scene_is_changing = false
		
func transition_curtain_close() -> void:
	pass
	
func fade_only() -> void:
	anim.play("fade_to_black")
	
	
	

	

	


	
