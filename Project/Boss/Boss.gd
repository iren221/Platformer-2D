extends CharacterBody2D

enum {
	IDLE,
	ATTACK,
	RUN,
	DAMAGE,
	DEATH
}

var state: int = 0:
	set(value):
		state = value
		match state:
			IDLE:
				pass
			ATTACK:
				pass
			RUN:
				pass
			DAMAGE:
				pass
			DEATH:
				pass

var speed = 100
var chase = false

@onready var anim = $AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	var player = $"../../Player/player"
	var direction = (player.position - self.position).normalized()
	if chase == true:
		velocity.x = direction.x * speed
		anim.play("Run")
	else:
		velocity.x = 0
		anim.play("Idle")
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
	move_and_slide()


func _on_detector_body_entered(body):
	if body.name == "player":
		chase = true
		print("Игрок зашел в поле Босса")


func _on_detector_body_exited(body):
	if body.name == "player":
		chase = false
		print("Игрок вышел из поля Босса")
