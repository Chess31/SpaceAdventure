/// @description Game Loop

//Game Quit
if (keyboard_check_pressed(vk_escape)) {
	game_end();
}

// Update the text adventure system
text_adventure_update();

// Handle input for the text adventure
text_adventure_handle_input();

//Custom Functionality

// Check which scene is currently active
if (current_scene == "message_01") {
    // Do something specific for this scene
	//game_end();
}