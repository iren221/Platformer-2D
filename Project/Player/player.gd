extends CharacterBody2D

signal health_changed(new_health)
	

enum {
	DEATH,
	DAMAGE,
	ATTACK,
	MOVE,
	JUMP, 
}

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimatedSprite2D
@onready var animPlayer = $AnimationPlayer
var health

var state = MOVE
var attack_cooldown = false
var max_health = 120
var damage_basic = 25
var damage_multiplier = 1

func _ready():
	Signals.connect("enemy_attack", Callable(self, "_on_damage_received"))
	health = max_health

func _physics_process(delta):
	
	match state:
		DAMAGE:
			damage_state()
		ATTACK:
			attack_state()
		DEATH:
			death_state()
		MOVE:
			move_state()
		JUMP:
			pass

	if not is_on_floor():
		velocity.y += gravity * delta
	if velocity.y > 0:
		animPlayer.play("Fall")
		

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animPlayer.play("Jump")
	move_and_slide()
	Global.player_pos = self.position
	
func move_state():
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			animPlayer.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			animPlayer.play("Idle")
	if direction == -1:
		anim.flip_h = true
		$AttackDirection.rotation_degrees = 180
	elif direction == 1:
		anim.flip_h = false
		$AttackDirection.rotation_degrees = 0
	if Input.is_action_just_pressed("attack") and attack_cooldown == false:
		state = ATTACK
		
func attack_state():
	damage_multiplier = 1
	velocity.x = 0
	animPlayer.play("Attack")
	await animPlayer.animation_finished
	attack_freez()
	state = MOVE

func attack_freez():
	attack_cooldown = true
	await get_tree().create_timer(0.5).timeout
	attack_cooldown = false
	
func damage_state():
	velocity.x = 0
	animPlayer.play("Damage")
	await animPlayer.animation_finished
	state = MOVE
	
func death_state():
	velocity.x = 0
	animPlayer.play("Death")
	await animPlayer.animation_finished
	queue_free()
	get_tree().change_scene_to_file.bind("res://menu.tscn").call_deferred()
	
	
func _on_damage_received(enemy_damage):
	health -= enemy_damage
	if health <= 0:
		health = 0
		state = DEATH
	else:
		state = DAMAGE
	emit_signal("health_changed", health)
	print(health)

func _on_hit_box_area_entered(area):
	Signals.emit_signal("player_attack", damage_basic)
