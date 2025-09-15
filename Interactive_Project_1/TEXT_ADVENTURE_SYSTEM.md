# Text Adventure System Documentation

## Overview
This modular text adventure system is designed for creating interactive sci-fi choose-your-own-adventure games with a retro CRT monitor aesthetic. The system provides a complete framework for managing story progression, text display, and player choices.

## Features
- **Typewriter Text Display**: Text appears character by character with customizable speed
- **Interactive Choice System**: Navigate choices with arrow keys or WASD
- **Scene Transitions**: Smooth transitions between story scenes
- **CRT Monitor Styling**: Green terminal text with retro aesthetics
- **Modular Story Structure**: Easy to add new scenes and story branches
- **Word Wrapping**: Automatic text wrapping for different screen sizes

## How to Use

### Basic Setup
The system is already integrated into `obj_game` and will start automatically when the game runs. The text adventure begins with the "start" scene.

### Controls
- **Arrow Keys** or **WASD**: Navigate between choices
- **Space** or **Enter**: Select a choice or skip to choices when text is complete
- **Escape**: Exit the game

### Adding New Story Content

To add new scenes to your story, modify the `load_story_data()` function in `script_text_engine.gml`:

```gml
// Example: Adding a new scene
var new_scene = ds_map_create();
ds_map_add(new_scene, "text", "Your story text here...");
ds_map_add(new_scene, "choices", ["Choice 1", "Choice 2", "Choice 3"]);
ds_map_add(new_scene, "outcomes", ["scene1", "scene2", "scene3"]);
ds_map_add(new_scene, "typewriter", true);
ds_map_add(new_scene, "delay", 30);

ds_map_add(story_data, "scene_id", new_scene);
```

### Scene Properties
- **text**: The main story text to display
- **choices**: Array of choice options (optional)
- **outcomes**: Array of scene IDs to transition to (must match choices array)
- **typewriter**: Whether to use typewriter effect (true/false)
- **delay**: Frames to wait before showing choices after text completes

### Story Structure
The current example story follows Commander Sarah Chen as she encounters mysterious alien structures in deep space. The story includes multiple branching paths and leads to different endings based on player choices.

### Customization Options

#### Text Speed
Modify `text_speed` in the initialization to change how fast text appears:
```gml
text_speed = 2; // Characters per frame (higher = faster)
```

#### Colors
The system uses classic terminal colors:
- **Green**: Default text color
- **Yellow**: Selected choice highlight
- **White**: Reset color

#### Panel Layout
Modify the panel dimensions in `text_adventure_draw()`:
```gml
var panel_x = 50;
var panel_y = 50;
var panel_width = room_width - 100;
var panel_height = room_height - 100;
```

## System Architecture

### Core Functions
- `text_adventure_init()`: Initialize the system
- `text_adventure_update()`: Update system state
- `text_adventure_draw()`: Render the interface
- `text_adventure_handle_input()`: Process player input
- `text_adventure_cleanup()`: Clean up resources

### State Management
The system uses several states:
- **idle**: System not active
- **displaying_text**: Showing story text with typewriter effect
- **showing_choices**: Displaying choice options
- **transitioning**: Moving between scenes

### Data Structure
Stories are stored in a `ds_map` where each scene is identified by a unique string ID. Each scene contains its text, choices, and outcomes.

## Extending the System

### Adding New Features
The modular design makes it easy to add new features:
- Sound effects for text typing
- Character portraits or images
- Inventory system
- Multiple save slots
- Achievement system

### External Story Files
For larger stories, consider loading content from external files:
```gml
// Example: Load from JSON file
var story_json = file_text_read("story.json");
var story_data = json_decode(story_json);
```

### Multiple Storylines
You can create multiple story branches by using different scene ID prefixes:
- `chapter1_start`, `chapter1_scene1`, etc.
- `chapter2_start`, `chapter2_scene1`, etc.

## Troubleshooting

### Common Issues
1. **Scene not found**: Ensure scene IDs match exactly between choices and outcomes
2. **Text not wrapping**: Check that `text_width` is appropriate for your font size
3. **Choices not appearing**: Verify that the scene has both "choices" and "outcomes" arrays

### Debug Information
The system includes debug messages for missing scenes. Check the output window for error messages.

## Example Story Paths
The current story includes several possible paths:
1. **Investigate → Respond → Ask Test → Accept Test → Save Both → Continue → Be Cautious → Accept Invitation**
2. **Scan → Continue Scanning** (leads to different outcomes)
3. **Contact Command → Wait for Reinforcements** (alternative path)

Each path offers different challenges and character development opportunities.

## Credits
This text adventure system was created for the Interactive Project 1 GameMaker Studio 2 project, featuring a sci-fi choose-your-own-adventure story with CRT monitor aesthetics.
