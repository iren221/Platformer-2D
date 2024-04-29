extends Node2D

@onready  var anim = $fire/fire/AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_fire_body_entered(body):
	if body.name == "Player":
		Signals.emit_signal("enemy_attack", 120)
