extends Area2D

@onready var anim = $AnimatedSprite2D
@onready var anim_player = $AnimatedSprite2D

func _ready():
	anim.play("default")



func _on_body_entered(body):
	if body.name == "Player":
		anim_player.play("Death")
		await anim_player.animation_finished
		queue_free()
		get_tree().change_scene_to_file.bind("res://menu.tscn").call_deferred()
