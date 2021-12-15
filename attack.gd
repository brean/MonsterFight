extends Button

export var _type = "fire"

func _pressed():
	get_node("../MonsterEnemy").attack(_type)
