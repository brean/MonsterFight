extends Button

export var _type = "fire"

func _pressed():
	var enemy_monster = get_node("../../MonsterEnemy")
	enemy_monster.attack(_type)
	var player_monster = get_node("../../MonsterPlayer")
	player_monster.play_attacking()
