extends Node

func set_player_enabled(enabled: bool):
	for player in get_tree().get_nodes_in_group("Player"):
		player.set_process(enabled)
		player.set_physics_process(enabled)
