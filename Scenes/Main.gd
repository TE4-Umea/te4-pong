extends Node

var side = 'p1'
var player_hp = 100
var p1_score = 0
var p2_score = 0
var ball_size = 0
var player_items_index : Array
var player_items_copy : Array
var enemy = "enemy"
var enemy_list = []
var boss = ""
var is_boss = false
var diff_scale = 1

func update_player_items_index(item_index):
	player_items_index.append(item_index)


func updete_player_items_copy(item_copy):
	player_items_copy = item_copy



