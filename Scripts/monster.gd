extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var health = 100
export var damage = {
	"fire": 50,
	"water": 5,
	"electro": 10
}
export var player = true
var attacks = ["fire", "water", "electro"]
export var fight_time = .5

var attack_animation = false
var attack_type = ''
var time = 0
var start_time = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func attack(_type):
	attack_animation = true
	start_time = time
	attack_type = _type
	
func calculate_attack():
	health -= damage[attack_type]
	check_end()
	if not player:
		fight_back()

func check_end():
	if health <= 0:
		get_node("..").remove_monster(player)

func fight_back():
	var current_attack = attacks[randi() % attacks.size()]
	get_node("../MonsterPlayer").attack(current_attack)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if attack_animation and start_time + fight_time < time:
		calculate_attack()
		attack_animation = false
	# Zeichne den Health-Balken neu (health * 2)
	get_node("HealthBar").scale.x = health * 2
	if player:
		get_node("HealthBar").position.x = -100 + health
	else:
		get_node("HealthBar").position.x = 100 - health
