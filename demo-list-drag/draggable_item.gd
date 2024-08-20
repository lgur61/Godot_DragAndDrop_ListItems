# draggable_item.gd
extends Panel
class_name Draggable

signal item_order_changed(item_id: int, new_order: int)

@onready var item_checkbox := %ItemCheckBox as CheckBox
@onready var drag_label := %DragLabel as Label
@onready var source_container := get_tree().current_scene.get_node("%SourceContainer")
@onready var rows_container := get_tree().current_scene.get_node("VLayout/DragAndDropColumns/SourceContainer/Padding/Rows") as VBoxContainer

var id: int
var item_name: String
var is_checked: bool


func _ready() -> void:		
	item_checkbox.text = item_name
	item_checkbox.button_pressed = is_checked
	item_order_changed.connect(source_container._on_item_order_changed)

func _get_drag_data(_position: Vector2):
	print("[Draggable] _get_drag_data has run")
	#if not dropped_on_target:
	set_drag_preview(_get_preview_control())
	apply_drag_border_color(self.id)
	return self


func _get_preview_control() -> Control:
	"""
	The preview control must not be in the scene tree. You should not free the control, and
	you should not keep a reference to the control beyond the duration of the drag.
	It will be deleted automatically after the drag has ended.
	"""
	## You can use custom controls as a preview control.
	# var preview = Panel.new()	
	# preview.size = size		
	# preview.set_rotation(.1) # in readians
	
	## Can use duplicated control as a preview control
	var dup: Draggable = self.duplicate(12)
	dup.item_name = item_name
	dup.set_rotation(.1)
	
	return dup


func _can_drop_data(_position: Vector2, data: Variant) -> bool:
	# To allow dragging and dropping over buttons, set the Mouse/Filter property to "Pass".
	# Refer to the documentation to understand how this change affects input handling.
	var can_drop: bool = data is Draggable 
	if not can_drop:
		print("[TargetContainer] _can_drop_data has run, returning %s" % can_drop)
	return can_drop

func _drop_data(_position: Vector2, data) -> void:
	print("[TargetContainer] _drop_data has run")
	print("[TargetContainer] Emiting signal: item_dropped_on_target")
	
	var drop_index = self.get_index()
	var drag_index = data.get_index()
	if drag_index == drop_index:
		return	
	
	rows_container.move_child(data, drop_index)
	
	item_order_changed.emit(data.id, drop_index)

func _notification(notification_type):
	match notification_type:
		NOTIFICATION_DRAG_END:
			clear_drag_border_color()


func apply_drag_border_color(selected_id: int) -> void:
	for child in rows_container.get_children():
		if child is Draggable and child.id != selected_id: 
				var stylebox_flat := StyleBoxFlat.new()
				stylebox_flat.set_border_width_all(2)
				stylebox_flat.border_color = Color.DARK_GRAY
				stylebox_flat.set_corner_radius_all(2)
				child.add_theme_stylebox_override("panel", stylebox_flat)

func clear_drag_border_color() -> void:
	for child in rows_container.get_children():
		if child is Draggable:  
				child.remove_theme_stylebox_override("panel")


func _on_item_check_box_toggled(toggled_on: bool) -> void:
	is_checked = toggled_on

