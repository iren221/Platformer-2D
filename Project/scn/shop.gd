extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	pass


func _on_back_pressed():
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_btn_buy_green_pressed():
	Global.money -= 5


func _on_btn_buy_blue_pressed():
	Global.money -= 5


func _on_btn_buy_red_pressed():
	Global.money -= 5
