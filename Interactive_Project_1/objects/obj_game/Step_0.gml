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

if ((current_scene == "preSecretFiles" or current_scene == "preSecretAlternate") and (button_exists == false)){
    // Show file system option
	button_exists = true;
	var _button = instance_create_layer(50,room_height-50,"Instances",obj_button);
	_button.type = 2;
}

if (current_scene == "resetTerminal" and button_exists == false) {
    // Show file system option
	button_exists = true;
	var _button = instance_create_layer(50, room_height - 50, "Instances", obj_button);
	_button.type = 1;
}

//Endings
if (current_scene == "ship_explodes_ending") {
    // create handler
	ending_exists = true;
	var _ending = instance_create_layer(590, room_height/2, "Instances", obj_ending_handler);
	_ending.sprite_index = spr_explode;
}
if (current_scene == "grovven_ending") {
    // create handler
	ending_exists = true;
	var _ending = instance_create_layer(590, room_height/2, "Instances", obj_ending_handler);
	_ending.sprite_index = spr_grovven;
}
if (current_scene == "bad_ending") {
    // create handler
	ending_exists = true;
	var _ending = instance_create_layer(590, room_height/2, "Instances", obj_ending_handler);
	_ending.sprite_index = spr_bad;
}