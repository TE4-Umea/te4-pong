extends Node

var side = 'p1'
var p1_score = 0
var p2_score = 0
var player_items : Array

func update_player_items(item):
	if player_items.size() >= 3:
		print("no more")
		
	else:
		player_items.append_array(item)

