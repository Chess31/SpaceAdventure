/// @description Game Loop

//Game Quit
if (keyboard_check_pressed(vk_escape)) {
	game_end();
}

// Update the text adventure system
text_adventure_update();

// Handle input for the text adventure
text_adventure_handle_input();

//Secret Endings

if ((current_scene == "start" or current_scene == "preSecretAlternate") and (button_exists == false)){
    // Show file system option
	button_exists = true;
	var _button = instance_create_layer(50,room_height-50,"Instances",obj_button);
	_button.type = 2;
}