# Drag and Drop List Items - Godot Demo Project

This project is a Godot-based drag-and-drop list items demonstration. It allows users to drag items within a list, rearranging them dynamically, with visual feedback provided during the drag operation.


https://github.com/lgur61/Godot_DragAndDrop_ListItems/blob/main/demo_recording.mp4

## Features

- **Drag and Drop:** Allows reordering items within a container using drag-and-drop.
- **Visual Feedback:** Items display a visual change (border color) when dragging is initiated and cleared once the item is dropped.
- **Custom Drag Preview:** A custom preview of the item being dragged is shown during the drag operation.

## Project Structure

- **`source_container.gd`**: Handles the initialization and population of draggable items, as well as updating their order after a drag-and-drop operation.
- **`draggable_item.gd`**: Manages individual draggable items, including the drag data, drop logic, and visual updates during the drag operation.

## How to Use

1. Clone or download the project.
2. Open the project in the Godot Engine.
3. Run the scene to see the drag-and-drop functionality in action.

## Setup Instructions

- Ensure that the `draggable.tscn` scene is preloaded in the `source_container.gd` script.
- Modify the array in `source_container.gd` to customize the list of draggable items.

## References and Acknowledgments

This project is based on and inspired by the work available at the following resources:

- GitHub Repository: [Explore Game Dev - Godot Demos](https://github.com/exploregamedev/Godot-demos)
- YouTube Tutorial: [Godot Drag and Drop by Explore Game Dev](https://www.youtube.com/watch?v=cNvzGKCkNXg)

The base code was adapted and extended to include additional features and functionality specific to this project.

## License

This project is open-source and free to use under the MIT License. 

## Contributing

Feel free to fork this project, submit pull requests, or report issues. Contributions are always welcome!
