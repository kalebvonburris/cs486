extends MeshInstance3D

# Called when the node enters the scene tree for the first time.
func _ready():
	# Pick a random number between
	# 0 and 2
	var a = randi_range(0, 2)
	
	# Pick an axis to rotate
	# 0 = x, 1 = y, 2 = z
	if a == 0:
		axis = Vector3(1, 0 ,0)
	if a == 1:
		axis = Vector3(0, 1 ,0)
	if a == 2:
		axis = Vector3(0, 0 ,1)
		
	# Pick a rotation speed
	angle = randf_range(5.0, 100.0)

	# Set random color vector	
	var r = randf_range(0, 0.01)
	var g = randf_range(0, 0.01)
	var b = randf_range(0, 0.01)
	color_vector = Vector3(r, g, b)

var axis = Vector3(0, 1, 0)
var angle = 0.0
var turnrate : float = 5.0 # in degrees/second
var color_vector = Vector3(0, 0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Do a little spin
	spin_self(delta)
	
	# Change colors
	change_colors(delta)
	
	# Apply spin to children (uh oh)
	for child in get_children():
		child.angle += angle * delta

	pass


func spin_self(delta : float):
	angle += turnrate * delta
	while angle > 360.0:
		angle = angle - 360.0
	transform.basis = Basis(axis, deg_to_rad(angle))
	
func change_colors(delta : float):
	var material = self.mesh.surface_get_material(0)
	
	if material is StandardMaterial3D:
		# red channel
		material.albedo_color.r += color_vector.x * delta
		while material.albedo_color.r > 1.0:
			material.albedo_color.r -= 1.0
		
		# green channel
		material.albedo_color.g += color_vector.y * delta
		while material.albedo_color.g > 1.0:
			material.albedo_color.g -= 1.0
			
		# blue channel
		material.albedo_color.b += color_vector.z * delta
		while material.albedo_color.b > 1.0:
			material.albedo_color.b -= 1.0
			
		self.mesh.surface_set_material(0, material)
		
	else:
		print("No material found!")
	pass
	
