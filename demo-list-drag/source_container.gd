# source_container.gd
extends Panel

@onready var draggable_scene: PackedScene = preload("res://demo-list-drag/draggable.tscn")
@onready var draggable_container = $Padding/Rows

var dragabbles = [
	{"id": 1, "item_name": "Item 1", "order": 0},
	{"id": 2, "item_name": "Item 2", "order": 1},
	{"id": 3, "item_name": "Item 3", "order": 2},
	{"id": 4, "item_name": "Item 4", "order": 3}
]


func _ready() -> void:	
	_populate_dragables()

func _populate_dragables():
	dragabbles.sort_custom(compare_order)
	for draggable_item in dragabbles:
		var drag_item = draggable_scene.instantiate()
		drag_item.id = draggable_item["id"]
		drag_item.item_name = draggable_item["item_name"]
		draggable_container.add_child(drag_item)

func _on_item_order_changed(item_id: int, new_order: int):
	update_order(dragabbles, item_id, new_order)
	print(dragabbles)


func compare_order(a, b):
	return a["order"] < b["order"]

func update_order(draggable_list, item_id, new_order):
	# Find the current item to move
	var target_item = null
	for item in draggable_list:
		if item["id"] == item_id:
			target_item = item
			break
	
	if not target_item:
		print("Item with id = %s not found." % item_id)
		return
	
	var current_order = target_item["order"]
	
	# Update the order for the target item
	target_item["order"] = new_order
	
	# Adjust the other items
	for item in draggable_list:
		if item["id"] != item_id:
			if new_order < current_order:
				if item["order"] >= new_order and item["order"] < current_order:
					item["order"] += 1
			elif new_order > current_order:
				if item["order"] > current_order and item["order"] <= new_order:
					item["order"] -= 1
	
	# Sort the list to reflect the new order
	draggable_list.sort_custom(compare_order)

