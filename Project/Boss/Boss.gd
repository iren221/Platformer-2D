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
				attack_state()
			RUN:
				run_state()
				#pass
			DAMAGE:
				damage_state()
			DEATH:
				death_state()

var speed = 100
var chase = false
var player
var direction
var damage = 50
@onready var anim = $AnimationPlayer

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	#var player = $"../../Player/player"
	move_and_slide()
	player = Global.player_pos

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
		
func attack_state():
	anim.play("Attack")
	await anim.animation_finished
	state = IDLE
	
func death_state():
	anim.play("Death")
	await anim.animation_finished
	Global.money += 200
	queue_free()

func damage_state():
	anim.play("Damage")
	await anim.animation_finished
	state = IDLE

func _on_area_2d_body_entered(body):
	state = ATTACK
	print("attack")


func _on_detector_body_entered(body):
	state = RUN


func _on_detector_body_exited(body):
	state = IDLE
	velocity.x = 0


func _on_hit_box_area_entered(area):
	Signals.emit_signal("enemy_attack", damage)


func _on_boss_health_damage_received_boss():
	state = IDLE
	state = DAMAGE


func _on_boss_health_no_health_boss():
	state = DEATH
