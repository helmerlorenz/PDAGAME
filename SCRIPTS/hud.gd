extends CanvasLayer
class_name HUD

@export var coin_label : Label
@export var portal_label : Label

func update_coin(number: int):
	coin_label.text = "x " + str(number)

func portal_opened():
	portal_label.text = "Portal Open!"

func portal_closed():
	portal_label.text = "Portal Closed... Get more coins!"
