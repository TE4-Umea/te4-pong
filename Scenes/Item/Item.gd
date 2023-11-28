extends Node

var player_item : Array

var item_name
var ability
var element
var damage
var hp
var luck
var movment_speed
var ball_speed

func set_player_item(item):
	player_item = item
	print(player_item)

func set_all_item_info():
	item_name = player_item[0]
	ability = player_item[1]
	element = player_item[2]
	damage = player_item[3]
	hp = player_item[4]
	luck = player_item[5]
	movment_speed = player_item[6]
	ball_speed = player_item[7]
