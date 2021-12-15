extends Button

export var _type = "fire"

func _pressed():
	var monster = get_node("../../MonsterEnemy")
	monster.attack(_type)
