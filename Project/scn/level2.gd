extends Node2D

@onready var level_text = $CanvasLayer/level_text
@onready var animPlayer = $CanvasLayer/level_anim
@onready var helth_player = $CanvasLayer/health_player
@onready var helth_boss = $CanvasLayer/health_boss

func _ready():
	level_text_fade()
	
func level_text_fade():
	animPlayer.play("anim_level_start")
	await get_tree().create_timer(3).timeout
	animPlayer.play("anim_level_out")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
