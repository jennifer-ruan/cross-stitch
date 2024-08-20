extends TextureRect

var grid_size: Vector2i = Vector2i(32, 32)
var cell_size: int = 16
@onready var position_label: RichTextLabel = $PositionLabel
var hover_color: Color = Color(0.2, 0.2, 0.2)

var image: Image

func _ready():
	image = Image.create_empty(grid_size.x * cell_size, grid_size.y * cell_size, false, Image.FORMAT_RGB8)
	texture = ImageTexture.create_from_image(image)
	
	draw_grid()
	
	self.gui_input.connect(_on_gui_input)

func draw_grid() -> void:
	image.fill(Color(1, 1, 1))
	
	for x in range(0, image.get_width(), cell_size):
		for y in range(0, image.get_height(), cell_size):
			# Draw the vertical lines
			for i in range(cell_size):
				if x + i < image.get_width():
					image.set_pixel(x + i, y, Color(0, 0, 0))  # Top border
					image.set_pixel(x + i, y + cell_size - 1, Color(0, 0, 0))  # Bottom border

			# Draw the horizontal lines
			for j in range(cell_size):
				if y + j < image.get_height():
					image.set_pixel(x, y + j, Color(0, 0, 0))  # Left border
					image.set_pixel(x + cell_size - 1, y + j, Color(0, 0, 0))  # Right border))
	
	texture.update(image)

func highlight_cell(grid_pos: Vector2i) -> void:
	draw_grid()

	var x = grid_pos.x * cell_size
	var y = grid_pos.y * cell_size
	for i in range(cell_size):
		for j in range(cell_size):
			image.set_pixel(x + i, y + j, hover_color)

	texture.update(image)  # Apply the changes to the texture

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var local_position = self.get_local_mouse_position()
		if self.get_rect().has_point(local_position):
			var grid_pos = get_grid_position(local_position)
			position_label.text = "Grid Position: " + str(grid_pos)
			highlight_cell(grid_pos)

func get_grid_position(local_position: Vector2) -> Vector2i:
	#var local_position = self.get_local_mouse_position()
	var x = int(local_position.x / cell_size)
	var y = int(local_position.y / cell_size)
	return Vector2i(x, y)
