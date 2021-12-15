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
export var fight_time = 2

var attack_animation_playing = false
var attack_type = ''
var time = 0
var start_time = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func attack(_type):
	# attack is called on the other monster that gets attacked
	attack_animation_playing = true
	play_getting_attacked()
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
	play_attacking()
	var current_attack = attacks[randi() % attacks.size()]
	get_node("../MonsterPlayer").attack(current_attack)

func play_attacking():
	# short animation that the monster is attacking the other one (short jump)
	var ani_player = get_node("Monster/AnimationPlayer")
	if ani_player:
		if player:
			ani_player.play("AttackingRight")
		else:
			ani_player.play("AttackingLeft")

func play_getting_attacked():
	# play short animation that the monster is attacked (short wiggle)
	var ani_player = get_node("Monster/AnimationPlayer")
	if ani_player:
		ani_player.play("WiggleAttacked")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if attack_animation_playing and start_time + fight_time < time:
		calculate_attack()
		attack_animation_playing = false
	# Zeichne den Health-Balken neu (health * 2)
	get_node("HealthBar").scale.x = health * 2
	if player:
		get_node("HealthBar").position.x = -100 + health
	else:
		get_node("HealthBar").position.x = 100 - health
