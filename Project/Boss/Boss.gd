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
				idle_state()
			ATTACK:
				pass
			RUN:
				#run_state()
				pass
			DAMAGE:
				pass
			DEATH:
				pass

var speed = 100
var chase = false
var player
var direction
@onready var anim = $AnimatedSprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	#var player = $"../../Player/player"
	player = Global.player_pos
	move_and_slide()

func idle_state():
	anim.play("Idle")

func run_state():
	direction = (player - self.position).normalized()
	velocity.x = direction.x * speed
	anim.play("Run")
	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
	

func _on_detector_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	state = RUN
	#print("Игрок зашел в поле Босса2")


func _on_detector_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	state = IDLE
	#print("Игрок вышел из поля Босса2")
