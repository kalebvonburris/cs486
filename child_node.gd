extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var parent = get_parent();
	print("Parent: ", parent.name)

var axis = Vector3(0,1,0)
var angle = 0.0
var turnrate : float = 120.0 # in degrees/second

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	angle += turnrate * delta
	if angle > 360.0:
		angle = angle - 360.0
	transform.basis = Basis(axis, deg_to_rad(angle))
