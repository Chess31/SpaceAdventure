type = 1;
hovered = false;
page = -1;

// Secondary button system
secondary_buttons = [];
button_spacing = 60;
button_width = 200;
button_height = 40;

//define fuinctions

// Function to setup secondary buttons based on page
function setup_secondary_buttons() {
	secondary_buttons = [];
	
	if (page == 1) {
		// Terminal reset page buttons
		var button_y = y - 180;
		secondary_buttons[0] = {
			text: "RESET TERMINAL",
			x: x + sprite_width + 50,
			y: button_y,
			width: button_width,
			height: button_height,
			action: "reset_terminal"
		};
		
		button_y += button_spacing;
		secondary_buttons[1] = {
			text: "CHANGE COLOR",
			x: x + sprite_width + 50,
			y: button_y,
			width: button_width,
			height: button_height,
			action: "change_color"
		};
		
		button_y += button_spacing;
		secondary_buttons[2] = {
			text: "SWITCH FONT",
			x: x + sprite_width + 50,
			y: button_y,
			width: button_width,
			height: button_height,
			action: "switch_font"
		};
	} else if (page == 2) {
		// Archive unlock page buttons
		var button_y = y - 180;
		secondary_buttons[0] = {
			text: "UNLOCK ARCHIVE",
			x: x + sprite_width + 50,
			y: button_y,
			width: button_width,
			height: button_height,
			action: "unlock_archive"
		};
		
		button_y += button_spacing;
		secondary_buttons[1] = {
			text: "CHANGE COLOR",
			x: x + sprite_width + 50,
			y: button_y,
			width: button_width,
			height: button_height,
			action: "change_color"
		};
		
		button_y += button_spacing;
		secondary_buttons[2] = {
			text: "SWITCH FONT",
			x: x + sprite_width + 50,
			y: button_y,
			width: button_width,
			height: button_height,
			action: "switch_font"
		};
	}
}

// Function to check clicks on secondary buttons
function check_secondary_button_clicks() {
	if (mouse_check_button_pressed(mb_left)) {
		for (var i = 0; i < array_length(secondary_buttons); i++) {
			var btn = secondary_buttons[i];
			if (mouse_x >= btn.x && mouse_x <= btn.x + btn.width &&
				mouse_y >= btn.y && mouse_y <= btn.y + btn.height) {
				execute_button_action(btn.action);
				break;
			}
		}
	}
}

// Function to execute button actions
function execute_button_action(action) {
	switch (action) {
		case "reset_terminal":
			//go to "resetTerminal02" scene
			text_adventure_start_scene("resetTerminal02");
			instance_destroy();
			break;
		case "change_color":
			menu_change_color();
			break;
		case "switch_font":
			menu_switch_font();
			break;
		case "unlock_archive":
			//go to "secretFiles" scene
			text_adventure_start_scene("secretFiles");
			instance_destroy();
			break;
		default:
			break;
	}
}