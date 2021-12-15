extends Node2D

export var player_monster = [
	{
		"image": preload("res://monster1.png")
	},
	{
		"image": preload("res://monster2.png")
	}
]
export var enemy_monster = [
	{
		"image": preload("res://monster3.png")
	},
	{
		"image": preload("res://monster4.png")
	}
]
var monster = preload("res://Monster.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	# spawn first player character
	spawn_monster(player_monster[0], "MonsterPlayer", true)
	# spawn first enemy
	spawn_monster(enemy_monster[0], "MonsterEnemy", false)

func spawn_monster(data, name, player):
	var inst = monster.instance()
	add_child(inst)
	inst.name = name
	inst.player = player
	inst.texture = data.image
	if not player:
		inst.position.x = 867
		inst.position.y = 133


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
