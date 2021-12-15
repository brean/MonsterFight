extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var health = 100
export var damage = {
	"fire": 50,
	"water": 5}
export var player = true
var attacks = ["fire", "water"]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func attack(_type):
	health -= damage[_type];
	check_end()
	if not player:
		fight_back()

func check_end():
	if health <= 0:
		if player:
			get_tree().change_scene("res://Lose.tscn")
		else:
			get_tree().change_scene("res://Win.tscn")

func fight_back():
	var current_attack = attacks[randi() % attacks.size()]
	get_node("../MonsterPlayer").attack(current_attack)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Zeichne den Health-Balken neu (health * 2)
	get_node("HealthBar").scale.x = health * 2
	if player:
		get_node("HealthBar").position.x = -100 + health
	else:
		get_node("HealthBar").position.x = 100 - health
