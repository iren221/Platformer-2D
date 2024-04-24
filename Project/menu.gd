extends Node2D


func _on_exit_button_pressed():
	get_tree().quit()


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://level.tscn")



func _on_shop_button_pressed():
	get_tree().change_scene_to_file("res://scn/shop.tscn")
