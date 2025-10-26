extends Node
class_name GameManager

var current_area := 1
var area_path := "res://SCENES/Areas/"
var hud : HUD
var coins := 0

func _ready() -> void:
	await get_tree().process_frame  # wait one frame to ensure everything loads
	hud = get_tree().get_first_node_in_group("hud")
	if hud:
		reset_coins()
	else:
		print("HUD not found in scene tree.")



func next_level():
	current_area += 1
	var full_path := area_path + "area_" + str(current_area) + ".tscn"

	if ResourceLoader.exists(full_path):
		get_tree().change_scene_to_file(full_path)
		await get_tree().process_frame
		set_up_area()

		# Reacquire HUD after scene changes
		hud = get_tree().get_first_node_in_group("hud")

		print("The player has moved to area " + str(current_area))
	else:
		print("Area scene not found:", full_path)


func set_up_area():
	reset_coins()

func add_coin():
	coins += 1
	hud.update_coin(coins)
	if coins >= 4:
		var portal := get_tree().get_first_node_in_group("area_exits") as AreaExit
		if portal:
			portal.open()
			hud.portal_opened()

func reset_coins():
	coins = 0
	hud.update_coin(coins)
	hud.portal_closed()
	print("Coins have been reset.")
