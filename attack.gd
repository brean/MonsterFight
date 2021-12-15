extends Button

export var _type = "fire"

func _pressed():
	get_node("../Monster1").attack(_type)
