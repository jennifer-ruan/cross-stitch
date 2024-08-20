extends GridContainer

var baseColor = Color.WHITE
var colors = [Color.MEDIUM_SLATE_BLUE, Color.GOLD, Color.HOT_PINK]
var curr_color = colors[0]
var is_dragging = false

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			is_dragging = event.pressed
			if is_dragging:
				# Set a random color at the start of dragging
				var random_color = randi() % colors.size()
				curr_color = colors[random_color]
		if event.button_index == MOUSE_BUTTON_RIGHT:
			is_dragging = event.pressed
			if is_dragging:
				curr_color = baseColor

func _process(_delta):
	if is_dragging:
		# Get the mouse position relative to the GridContainer
		var mouse_pos = get_global_mouse_position()

		# Iterate through all the ColorRects
		for color_rect in get_children():
			var rect = color_rect as ColorRect
			# Check if the mouse position is within the bounds of this ColorRect
			if rect.get_global_rect().has_point(mouse_pos):
				rect.color = curr_color
				break  # Stop checking other rects once we find one under the cursor
