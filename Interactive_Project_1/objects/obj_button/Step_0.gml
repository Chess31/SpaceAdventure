/// @description Insert description here

//hover check
if (place_meeting(x,y,obj_cursor)) {
	hovered = true;
} else {
	hovered = false;
}

//activate secondary menu
if (hovered) {
	image_index = 1;
	if (type = 2) { //archive unlock
		if (mouse_check_button_pressed(mb_left)) {
			page = 2;
		}
	} else { //terminal reset
		if (mouse_check_button_pressed(mb_left)) {
			page = 1;
		}
	}
} else {
	image_index = 0;
}

//Check for secondary menu clicks
if (obj_cursor.y > 700 and obj_cursor.y < 800) {
	//button function 1 (also check for y coord? Or find a better way to check for buttons)
}