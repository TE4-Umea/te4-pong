extends Node

var side = 'p1'
var player_hp = 100
var p1_score = 0
var p2_score = 0
var ball_size = 0
var player_items : Array

func update_player_items(item):
	player_items.append(item)
	print(item)
	print(player_items)


