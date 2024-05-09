extends Node2D

@onready var pause_menu2 = $"../CanvasLayer/PauseMenu"

var game_paused2: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		game_paused2 = !game_paused2
		
	if game_paused2 == true:
		get_tree().paused = true
		pause_menu2.show()
	else:
		get_tree().paused = false
		pause_menu2.hide()


func _on_resume_pressed():
	game_paused2 = !game_paused2


func _on_shop_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scn/shop.tscn")


func _on_quiet_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menu.tscn")
