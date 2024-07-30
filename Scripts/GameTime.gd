extends Label

var minutes = 0
var seconds = 0
signal end_game

# Called when the node enters the scene tree for the first time.
func _ready():
	text = str(minutes, ":0",  seconds)


func _on_timer_timeout():
	seconds += 1
	if seconds == 60:
		minutes += 1
		seconds = 0
	if seconds < 10:
		text = str(minutes, ":0", seconds)
	else:
		text = str(minutes, ":", seconds)
	if minutes == 5:
		end_game.emit()
