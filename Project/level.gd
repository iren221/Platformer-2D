extends Node2D

@onready var level_text = $CanvasLayer/NumberLevel
@onready var animPlayer = $CanvasLayer/AnimationPlayer
@onready var health_bar = $CanvasLayer/HealthBar
@onready var player = $Player/Player

func _ready():
	health_bar.max_value = player.max_health
	health_bar.value = health_bar.max_value
	level_text_fade()

func level_text_fade():
	animPlayer.play("level_text_fade_in")
	await get_tree().create_timer(3).timeout
	animPlayer.play("level_text_fade_out")


func _on_player_health_changed(new_health):
	health_bar.value = new_health

