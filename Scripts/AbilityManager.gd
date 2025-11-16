extends Node

# Store unlocked abilities
var abilities = {
	"Run": false,
	"Wall_Jump": false,
	"Dash": false
}

func unlock(ability_name: String):
	if abilities.has(ability_name):
		abilities[ability_name] = true

func has(ability_name: String) -> bool:
	return abilities.get(ability_name, false)
