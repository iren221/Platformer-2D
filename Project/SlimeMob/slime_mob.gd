extends CharacterBody2D

enum {
	IDLE,
	ATTACK,
	CHASE,
	DAMAGE,
	DEATH,
	RECOVER
}

var state: int = 0:
	set(value):
		state = value
		match state:
			IDLE:
				idle_state()
			ATTACK:
				attack_state()
			CHASE:
				#chase_state()
				pass
			DAMAGE:
				damage_state()
			DEATH:
				death_state()
			RECOVER:
				recover_state()
			
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var direction
var damage = 20
var speed = 50
@onready var animPlayer = $AnimationPlayer
@onready var sprite = $AnimatedSprite2D


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
	player = Global.player_pos

func _on_detector_body_entered(body):
	if body.name == "Player":
		pass


func _on_attack_range_body_entered(body):
	state = ATTACK
	
func idle_state():
	animPlayer.play("Idle")
	
	
func attack_state():
	animPlayer.play("Attack")
	await animPlayer.animation_finished
	state = RECOVER

func chase_state():
	animPlayer.play("Run")
	direction = (player - self.position).normalized()
	if direction.x < 0:
		sprite.flip_h = false
		$AttackeDirection.rotation_degrees = 0
	else:
		sprite.flip_h = true
		$AttackeDirection.rotation_degrees = 180
	velocity.x = direction.x * speed
	

func _on_hit_box_area_entered(area):
	Signals.emit_signal("enemy_attack", damage)
	


func damage_state():
	animPlayer.play("Damage")
	await animPlayer.animation_finished
	state = IDLE

func death_state():
	animPlayer.play("Death")
	await animPlayer.animation_finished
	Global.money += 15
	queue_free()
	
func recover_state():
	animPlayer.play("Recover")
	await animPlayer.animation_finished
	animPlayer.play("Idle")


func _on_mob_health_no_health():
	state = DEATH


func _on_mob_health_damage_received():
	state = IDLE
	state = DAMAGE


