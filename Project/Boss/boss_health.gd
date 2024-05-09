extends Node2D

signal no_health_boss()
signal damage_received_boss()

@onready var health_bar = $health

var player_dmg

var health = 200:
	set(value):
		health = value
		health_bar.value = health
		#if health <= 0:
			#health_bar.visible = false
		#else:
			#health_bar.visible = true
		
func _ready():
	Signals.connect("player_attack", Callable(self, "_on_damage_received"))
	health_bar.max_value = health
	#health_bar.visible = false


func _on_hurt_box_area_entered(area):
	await get_tree().create_timer(0.05).timeout
	health -= player_dmg
	if health <= 0:
		emit_signal("no_health")
	else:
		emit_signal("damage_received")
