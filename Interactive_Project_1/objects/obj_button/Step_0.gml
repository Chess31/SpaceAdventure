/// @description Insert description here

//hover check
if (place_meeting(x,y,obj_cursor)) {
	hovered = true;
	image_index = 1;
} else {
	hovered = false;
	image_index = 0;
}

//activate secondary menu
if (hovered) and (mouse_check_button_pressed(mb_left)){
	if (type = 2) { //archive unlock
		page = 2;
		setup_secondary_buttons();
	} else { //terminal reset
		page = 1;
		setup_secondary_buttons();
	}
}

// Check for secondary menu clicks
if (page > 0) {
	check_secondary_button_clicks();
}