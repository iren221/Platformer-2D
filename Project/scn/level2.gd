extends Node2D

@onready var level_text = $CanvasLayer/level_text
@onready var animPlayer = $CanvasLayer/level_anim
@onready var health_bar = $CanvasLayer/health_player
@onready var player = $Player/player

func _ready():
	health_bar.max_value = player.max_health
	health_bar.value = health_bar.max_value
	level_text_fade()
	
func level_text_fade():
	animPlayer.play("anim_level_start")
	await get_tree().create_timer(3).timeout
	animPlayer.play("anim_level_out")


func _on_player_health_changed(new_health):
	health_bar.value = new_health
