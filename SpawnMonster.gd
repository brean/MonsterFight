extends Node2D

export var player_monster = [
	{
		"image": preload("res://monster1.png"),
		"health": 100,
		"damage": {
			"fire": 50,
			"water": 10
		}
	},
	{
		"image": preload("res://monster2.png"),
		"health": 100,
		"damage": {
			"fire": 50,
			"water": 10
		}
	}
]
export var enemy_monster = [
	{
		"image": preload("res://monster3.png"),
		"health": 100,
		"damage": {
			"fire": 50,
			"water": 10
		}
	},
	{
		"image": preload("res://monster4.png"),
		"health": 100,
		"damage": {
			"fire": 50,
			"water": 10
		}
	}
]
var monster = preload("res://Monster.tscn")
var current_enemy
var current_player


# Called when the node enters the scene tree for the first time.
func _ready():
	# spawn first player character
	current_player = spawn_monster(player_monster[0], "MonsterPlayer", true)
	# spawn first enemy
	current_enemy = spawn_monster(enemy_monster[0], "MonsterEnemy", false)

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

func remove_monster(player):
	if player:
		current_player.name = "dead"
		current_player.queue_free()
		player_monster.remove(0)
		if len(player_monster) == 0:
			get_tree().change_scene("res://Lose.tscn")
			return
		current_player = spawn_monster(player_monster[0], "MonsterPlayer", true)
	else:
		current_enemy.name = "dead"
		current_enemy.queue_free()
		enemy_monster.remove(0)
		if len(enemy_monster) == 0:
			get_tree().change_scene("res://Win.tscn")
			return
		current_enemy = spawn_monster(enemy_monster[0], "MonsterEnemy", false)
