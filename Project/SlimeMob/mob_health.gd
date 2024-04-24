extends Node2D

signal no_health()
signal damage_received()

@onready var health_bar = $HealthBar
@onready var damage_text = $DamageText
@onready var animPlayer = $AnimationPlayer

var player_dmg

var health = 100:
	set(value):
		health = value
		health_bar.value = health
		if health <= 0:
			health_bar.visible = false
		else:
			health_bar.visible = true
		
func _ready():
	Signals.connect("player_attack", Callable(self, "_on_damage_received"))
	damage_text.modulate.a = 0
	health_bar.max_value = health
	health_bar.visible = false

func _on_damage_received(damage_basic):
	player_dmg = damage_basic


func _on_hurt_box_area_entered(area):
	await get_tree().create_timer(0.05).timeout
	health -= player_dmg
	damage_text.text = str (player_dmg)
	animPlayer.stop()
	animPlayer.play("damage_text")
	if health <= 0:
		emit_signal("no_health")
	else:
		emit_signal("damage_received")
