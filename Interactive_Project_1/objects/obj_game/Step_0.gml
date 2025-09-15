/// @description Game Loop

//Game Quit
if (keyboard_check_pressed(vk_escape)) {
	game_end();
}

// Update the text adventure system
text_adventure_update();

// Handle input for the text adventure
text_adventure_handle_input();