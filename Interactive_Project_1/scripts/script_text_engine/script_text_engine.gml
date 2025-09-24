// global variables
globalvar current_text;
globalvar current_choice;
globalvar text_timer;
globalvar text_position;
globalvar show_choices;
globalvar current_scene;
globalvar story_scenes;

// Initialize
function text_adventure_init() {
    // Initialize all global variables first
    current_scene = "start"; //first scene must be named "start"
    current_choice = 0;
    text_timer = 0;
    text_position = 0;
    show_choices = false;
    current_text = "";
    
    // Load story scenes
    load_story_scenes();
    text_adventure_start_scene(current_scene);
}

// Load all story scenes from JSON file
function load_story_scenes() {
    story_scenes = ds_map_create();
    
    // Load story from JSON file in datafiles folder
    var file = file_text_open_read("story.json");
    if (file != -1) {
        var json_string = "";
        while (!file_text_eof(file)) {
            json_string += file_text_read_string(file);
            file_text_readln(file); // Skip the newline
        }
        file_text_close(file);
        
        // Parse the JSON string
        var story_json = json_parse(json_string);
        if (is_struct(story_json)) {
            // Copy all scenes from JSON to the story_scenes map
            var keys = variable_struct_get_names(story_json);
            for (var i = 0; i < array_length(keys); i++) {
                var scene_id = keys[i];
                var scene_data = variable_struct_get(story_json, scene_id);
                ds_map_add(story_scenes, scene_id, scene_data);
            }
            show_debug_message("Story loaded from story.json successfully!");
            return;
        }
    }
    
    // No fallback - let the game fail to help with debugging
    show_debug_message("FATAL: Cannot load story data. Check datafiles/story.json file!");
}

// Start a new scene
function text_adventure_start_scene(scene_id) {
    current_scene = scene_id;
    var scene = story_scenes[? scene_id];
    
    // Handle both struct and ds_map scene data
    if (is_struct(scene)) {
        current_text = variable_struct_get(scene, "text");
    } else {
        current_text = scene[? "text"];
    }
    
    text_position = 0;
    show_choices = false;
    current_choice = 0;
}

// update function
function text_adventure_update() {
    text_timer++;
    
    // typewriter findme
    if (text_timer >= 1 && text_position < string_length(current_text)) {
        text_position++;
        text_timer = 0;
    }
    
    // Show choices after text is complete
    if (text_position >= string_length(current_text) && !show_choices) {
        show_choices = true;
    }
}

// input handling
function text_adventure_handle_input() {
    if (show_choices) {
        var scene = story_scenes[? current_scene];
        var choices, outcomes;
        
        // Handle both struct and ds_map scene data
        if (is_struct(scene)) {
            choices = variable_struct_get(scene, "choices");
            outcomes = variable_struct_get(scene, "outcomes");
        } else {
            choices = scene[? "choices"];
            outcomes = scene[? "outcomes"];
        }
        
        var num_choices = array_length(choices);
        
        // Handle choice navigation
        if (keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))) {
            current_choice--;
            if (current_choice < 0) current_choice = num_choices - 1;
        }
        if (keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))) {
            current_choice++;
            if (current_choice >= num_choices) current_choice = 0;
        }
        
        // Handle choice selection
        if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
            var next_scene = outcomes[current_choice];
            
            // Special handling for exit_game
            if (next_scene == "exit_game") {
                game_end();
                return;
            }
            
            // Start the next scene
            text_adventure_start_scene(next_scene);
        }
    } else {
        // Handle text skipping when not showing choices
        if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
            // If text is still typing, skip to the end
            if (text_position < string_length(current_text)) {
                text_position = string_length(current_text);
                show_choices = true;
            }
            // If text is complete but choices aren't showing yet, show them
            else if (text_position >= string_length(current_text) && !show_choices) {
                show_choices = true;
            }
        }
    }
}

// Helper function for word wrapping
function wrap_text(text, max_width) {
    var words = string_split(text, " ");
    var result = "";
    var current_line = "";
    
    for (var i = 0; i < array_length(words); i++) {
        var test_line = current_line + words[i] + " ";
        if (string_width(test_line) > max_width && current_line != "") {
            result += current_line + "\n";
            current_line = words[i] + " ";
        } else {
            current_line = test_line;
        }
    }
    
    if (current_line != "") {
        result += current_line;
    }
    
    return result;
}

// Draw function
function text_adventure_draw() {
    
    // Set up drawing
    draw_set_font(ft_Retro);
    draw_set_color(c_green);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    // Define text area (upper left section)
    var text_area_x = 50;
    var text_area_y = 50;
    var text_area_width = room_width / 2 + 100; // Half screen width minus margins
    var text_area_height = room_height - 100; // Half screen height minus margins
    
    // Draw border around story text area
    draw_set_color(c_green);
    draw_rectangle(text_area_x, text_area_y, text_area_x * 2 + text_area_width, text_area_y + text_area_height, true);
    
    // Draw title for story text area
    draw_set_color(c_yellow);
    draw_text(text_area_x + 20, text_area_y + 5, "SHIP LOG:");
    
    // Draw the current text (typewriter effect) in upper left
    var display_text = string_copy(current_text, 1, text_position);
    
    // Word wrap the text to fit the text area
    var wrapped_text = wrap_text(display_text, text_area_width);
    var lines = string_split(wrapped_text, "\n");
    
    var y_pos = text_area_y + 35; // Add padding inside border + space for title
	draw_set_color(c_green);
    for (var i = 0; i < array_length(lines); i++) {
        draw_text(text_area_x + 20, y_pos, lines[i]); // Add padding inside border
        y_pos += 30;
    }
    
    // Define choices area (bottom right section)
    var choice_area_x = room_width / 2 + 250;
    var choice_area_y = room_height / 2 + 50;
    var choice_area_width = room_width / 2 - 300;
    var choice_area_height = room_height / 2 - 100;
    
    // Draw border around choices area
    draw_set_color(c_green);
    draw_rectangle(choice_area_x, choice_area_y, choice_area_x + choice_area_width, choice_area_y + choice_area_height, true);
    
    // Draw title for choices area
    draw_set_color(c_yellow);
    draw_text(choice_area_x + 20, choice_area_y + 5, "COMMAND LINE:");
    
    // Draw choices if ready
    if (show_choices) {
        var scene = story_scenes[? current_scene];
        var choices;
        
        // Handle both struct and ds_map scene data
        if (is_struct(scene)) {
            choices = variable_struct_get(scene, "choices");
        } else {
            choices = scene[? "choices"];
        }
        
        // Position choices inside the border
        var choice_x = choice_area_x + 20; // Add padding inside border
        var choice_y = choice_area_y + 50; // Add padding inside border + space for title
        var choice_line_height = 30;
        var choice_inner_width = choice_area_width - 40; // account for left/right padding

        // Draw each choice with word wrapping similar to the ship log
        for (var i = 0; i < array_length(choices); i++) {
            var choice_prefix = string(i + 1) + ". ";
            var choice_text_full = choice_prefix + string(choices[i]);

            var wrapped_choice = wrap_text(choice_text_full, choice_inner_width);
            var wrapped_lines = string_split(wrapped_choice, "\n");

            if (i == current_choice) {
                draw_set_color(c_yellow); // Highlight selected choice block
            } else {
                draw_set_color(c_green);
            }

            for (var j = 0; j < array_length(wrapped_lines); j++) {
                draw_text(choice_x, choice_y, wrapped_lines[j]);
                choice_y += choice_line_height;
            }

            // Add a small gap between choices
            choice_y += 6;
        }
    }
    
    // Draw cursor if typing
	draw_set_color(c_green);
    if (text_position < string_length(current_text)) {
        var last_line = lines[array_length(lines) - 1];
        draw_text(text_area_x + 20 + string_width(last_line), y_pos - 25, "_");
    }
    
    draw_set_color(c_white);
}

// Simple cleanup
function text_adventure_cleanup() {
    if (ds_exists(story_scenes, ds_type_map)) {
        ds_map_destroy(story_scenes);
    }
}