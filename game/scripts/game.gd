extends Node2D
class_name GameMaster

var pizza_count = 0
var players = []


func picked_up_pizza():
	pizza_count += 1
	if pizza_count >= 8:
		print("j'ai tout")
