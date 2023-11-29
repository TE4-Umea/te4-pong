extends Node

var player_item : Array

var item_name
var desc
var ability
var rarity
var element
var damage
var hp
var luck
var movment_speed
var ball_speed

signal signal_player_for_item

func set_player_item(item):
	player_item = item
	set_all_item_info()

func set_all_item_info():
	item_name = player_item[0]
	desc = player_item[1]
	ability = player_item[2]
	rarity = player_item[3]
	element = player_item[4]
	damage = player_item[5]
	hp = player_item[6]
	luck = player_item[7]
	movment_speed = player_item[8]
	ball_speed = player_item[9]
	emit_signal("signal_player_for_item")

func give_item_to_player():
	return [item_name, desc, ability, rarity, element, damage, hp, luck, movment_speed, ball_speed]
	player_item = []
