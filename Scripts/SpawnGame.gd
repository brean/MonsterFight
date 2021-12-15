extends Node2D

var attack_names = {
	"fire": "Feuer",
	"water": "Wasser",
	"electro": "Elektroschock"
}

export var player_monster = [
	{
		"image": preload("res://Images/monster1.png"),
		"health": 100,
		"damage": {
			"fire": 50,
			"water": 10,
			"electro": 5
		},
		"attacks": ["fire", "water"]
	},
	{
		"image": preload("res://Images/monster2.png"),
		"health": 100,
		"damage": {
			"fire": 50,
			"water": 10,
			"electro": 5
		},
		"attacks": ["fire", "water", "electro"]
	}
]
export var enemy_monster = [
	{
		"image": preload("res://Images/monster3.png"),
		"health": 100,
		"damage": {
			"fire": 50,
			"water": 10,
			"electro": 5
		},
		"attacks": ["fire", "water"]
	},
	{
		"image": preload("res://Images/monster4.png"),
		"health": 100,
		"damage": {
			"fire": 50,
			"water": 10,
			"electro": 5
		},
		"attacks": ["fire", "water"]
	}
]
var monster = preload("res://Scenes/Monster.tscn")
var button = preload("res://Scenes/attack.tscn")
var current_enemy
var current_player
var current_button = []


# Called when the node enters the scene tree for the first time.
func _ready():
	# spawn first player character
	current_player = spawn_monster(player_monster[0], "MonsterPlayer", true)
	# spawn first enemy
	current_enemy = spawn_monster(enemy_monster[0], "MonsterEnemy", false)
	show_attack()

func spawn_monster(data, name, player):
	var inst = monster.instance()
	add_child(inst)
	inst.name = name
	inst.player = player
	inst.texture = data.image
	inst.health = data.health
	inst.damage = data.damage
	if not player:
		inst.position.x = 867
		inst.position.y = 133
	return inst

func show_attack():
	# 1. remove old buttons
	for old_btn in current_button:
		old_btn.queue_free()
	current_button = []
	# 2. get monster to create new buttons
	var data = player_monster[0]
	var i = 0
	for attack in data.attacks:
		var btn = button.instance()
		add_child(btn)
		var text_button = btn.get_node("Button")
		text_button._type = attack
		text_button.text = attack_names[attack]
		btn.position.x = 480
		btn.position.y = 40.0 * i + 450
		i += 1

func remove_monster(player):
	if player:
		current_player.name = "dead"
		current_player.queue_free()
		player_monster.remove(0)
		# check lose condition
		if len(player_monster) == 0:
			get_tree().change_scene("res://Scenes/Lose.tscn")
			return
		current_player = spawn_monster(player_monster[0], "MonsterPlayer", true)
		show_attack()
	else:
		current_enemy.name = "dead"
		current_enemy.queue_free()
		enemy_monster.remove(0)
		# check win condition
		if len(enemy_monster) == 0:
			get_tree().change_scene("res://Scenes/Win.tscn")
			return
		current_enemy = spawn_monster(enemy_monster[0], "MonsterEnemy", false)
