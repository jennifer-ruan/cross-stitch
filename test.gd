extends GridContainer

var baseColor = Color.WHITE
var colors = [Color.MEDIUM_SLATE_BLUE, Color.GOLD, Color.HOT_PINK]

func _ready() -> void:
	for color_rect in get_children():
		var rect = color_rect as ColorRect
		rect.gui_input.connect(self._on_rect_click.bind(rect))

func _on_rect_click(event, color_rect):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var random_color = randi() % colors.size()
			color_rect.color = colors[random_color]
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			color_rect.color = baseColor
		
