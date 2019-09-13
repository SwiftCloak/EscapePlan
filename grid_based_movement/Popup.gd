extends Popup

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _ready():
	pass
# Called when the node enters the scene tree for the first time.
func _process(delta):
	if(variable.gameState == 2):
		popup() # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
