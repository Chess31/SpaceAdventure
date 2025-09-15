/// @description Simple Text Adventure Engine
/// @author AI Assistant
/// @version 1.0

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
    current_scene = "start";
    current_choice = 0;
    text_timer = 0;
    text_position = 0;
    show_choices = false;
    
    // Load story scenes
    load_story_scenes();
    
    // Start with the first scene
    text_adventure_start_scene(current_scene);
}

// Load all story scenes from JSON file
function load_story_scenes() {
    story_scenes = ds_map_create();
    
    // Try to load story from JSON file
    if (file_exists("story.json")) {
        var story_json = file_text_read("story.json");
        if (story_json != "") {
            var story_data = json_decode(story_json);
            if (ds_exists(story_data, ds_type_map)) {
                // Copy all scenes from JSON to our story_scenes map
                var keys = ds_map_keys_to_array(story_data);
                for (var i = 0; i < array_length(keys); i++) {
                    var scene_id = keys[i];
                    var scene_data = story_data[? scene_id];
                    ds_map_add(story_scenes, scene_id, scene_data);
                }
                show_debug_message("Story loaded from story.json successfully!");
                return;
            }
        }
    }
    
    // Fallback: Load default story if JSON file doesn't exist or is invalid
    show_debug_message("story.json not found or invalid, loading default story...");
    load_default_story();
}

// Load default story (fallback)
function load_default_story() {
    // Start scene
    var start_scene = ds_map_create();
    ds_map_add(start_scene, "text", "\nYou are Commander Sarah Chen aboard the U.S.S. Discovery. Your ship has detected a mysterious signal from deep space. The readings are unlike anything in your database.\n\nWhat do you do?");
    ds_map_add(start_scene, "choices", ["Investigate the signal", "Scan from safe distance", "Contact Star Command"]);
    ds_map_add(start_scene, "outcomes", ["investigate", "scan", "contact"]);
    ds_map_add(story_scenes, "start", start_scene);
    
    // Investigate scene
    var investigate_scene = ds_map_create();
    ds_map_add(investigate_scene, "text", "You order the Discovery to approach the signal source. As you draw closer, your sensors detect a massive alien structure that defies known physics.\n\nSuddenly, your ship is caught in an energy field. A voice echoes through your comm system:\n\n'Welcome, Commander Chen. We are the Architects. You have been chosen to participate in the Great Test.'");
    ds_map_add(investigate_scene, "choices", ["Respond to the voice", "Try to break free", "Analyze the communication"]);
    ds_map_add(investigate_scene, "outcomes", ["respond", "break_free", "analyze"]);
    ds_map_add(story_scenes, "investigate", investigate_scene);
    
    // Scan scene
    var scan_scene = ds_map_create();
    ds_map_add(scan_scene, "text", "You maintain a safe distance and begin detailed scans. Your science officer reports:\n\n'Commander, this structure is generating its own gravitational field and manipulating local space-time. It's unlike anything in our database.'\n\nYour long-range sensors detect multiple other similar structures throughout the sector.");
    ds_map_add(scan_scene, "choices", ["Continue scanning", "Move to another structure", "Return to Star Command"]);
    ds_map_add(scan_scene, "outcomes", ["continue_scan", "move_another", "return_command"]);
    ds_map_add(story_scenes, "scan", scan_scene);
    
    // Contact scene
    var contact_scene = ds_map_create();
    ds_map_add(contact_scene, "text", "You open a subspace channel to Star Command. After a brief delay, Admiral Thompson responds:\n\n'Commander Chen, this is highly unusual. We're seeing your telemetry data here. That structure... our records show nothing like it. Proceed with extreme caution. We're sending reinforcements, but they won't arrive for three days.'\n\nAs the transmission ends, you notice something disturbing - the structure appears to have moved closer to your ship.");
    ds_map_add(contact_scene, "choices", ["Wait for reinforcements", "Investigate immediately", "Evacuate the sector"]);
    ds_map_add(contact_scene, "outcomes", ["wait_reinforcements", "investigate_now", "evacuate"]);
    ds_map_add(story_scenes, "contact", contact_scene);
    
    // Respond scene
    var respond_scene = ds_map_create();
    ds_map_add(respond_scene, "text", "You activate your comm system and respond: 'This is Commander Sarah Chen of the U.S.S. Discovery. Who are you?'\n\nThe voice replies with what sounds like amusement: 'We are the Architects. We have been waiting for your species to reach this level of development. You have been chosen to participate in the Great Test.'\n\nYour science officer whispers urgently: 'Commander, I'm detecting massive energy readings from the structure. It's powering up something...'");
    ds_map_add(respond_scene, "choices", ["Ask about the Great Test", "Demand answers", "Prepare for battle"]);
    ds_map_add(respond_scene, "outcomes", ["ask_test", "demand_answers", "prepare_battle"]);
    ds_map_add(story_scenes, "respond", respond_scene);
    
    // Ask test scene
    var ask_test_scene = ds_map_create();
    ds_map_add(ask_test_scene, "text", "'What is this Great Test you speak of?' you ask.\n\nThe voice responds: 'The Great Test determines whether a species is ready to join the Galactic Community. It tests your wisdom, courage, and ability to work together. Many species have failed this test.'\n\n'What happens to those who fail?' you ask.\n\n'They are... contained. Until they are ready to try again. But you, Commander Chen, show promise. You may yet succeed where others have failed.'");
    ds_map_add(ask_test_scene, "choices", ["Accept the test", "Refuse to participate", "Ask for more information"]);
    ds_map_add(ask_test_scene, "outcomes", ["accept_test", "refuse_test", "more_info"]);
    ds_map_add(story_scenes, "ask_test", ask_test_scene);
    
    // Accept test scene
    var accept_test_scene = ds_map_create();
    ds_map_add(accept_test_scene, "text", "You take a deep breath and respond: 'We accept your test. Humanity is ready to prove ourselves.'\n\nThe structure begins to glow brighter, and you feel a strange sensation - as if you're being transported somewhere else. When the light fades, you find yourself in what appears to be a vast, alien laboratory.\n\nA holographic figure appears before you - a being that looks vaguely humanoid but clearly alien. 'Welcome to the Test Chamber, Commander Chen. Your first challenge awaits. You must choose: save your crew, or save a planet full of strangers. You have one hour to decide.'");
    ds_map_add(accept_test_scene, "choices", ["Save your crew", "Save the alien planet", "Try to save both"]);
    ds_map_add(accept_test_scene, "outcomes", ["save_crew", "save_planet", "save_both"]);
    ds_map_add(story_scenes, "accept_test", accept_test_scene);
    
    // Save both scene (the heroic choice)
    var save_both_scene = ds_map_create();
    ds_map_add(save_both_scene, "text", "You refuse to accept the false choice. 'I won't choose between innocent lives!' you declare. 'There must be another way!'\n\nYou begin analyzing the test chamber, looking for weaknesses in the system. Your engineering background kicks in as you notice patterns in the energy flows.\n\n'Commander!' your science officer calls out. 'I think I can reroute the power systems to create a feedback loop that will neutralize both threats!'\n\nWorking together, you and your crew manage to save both your ship and the alien planet. The holographic figure appears again, but this time it's smiling.\n\n'Excellent, Commander Chen. You have shown wisdom beyond your years. You have passed the first test. Welcome to the Galactic Community.'");
    ds_map_add(save_both_scene, "choices", ["Accept the invitation", "Ask about responsibilities", "Request to return home"]);
    ds_map_add(save_both_scene, "outcomes", ["accept_invitation", "ask_responsibilities", "return_home"]);
    ds_map_add(story_scenes, "save_both", save_both_scene);
    
    // Accept invitation scene (ending)
    var accept_invitation_scene = ds_map_create();
    ds_map_add(accept_invitation_scene, "text", "You accept the invitation with honor and humility. 'Thank you. I accept this responsibility on behalf of humanity.'\n\nThe alien proctor smiles. 'Excellent. You will serve as humanity's ambassador to the Galactic Community. Your species has much to learn, but also much to teach.'\n\nYou are returned to your ship, but now it's equipped with advanced technology and communication systems that will allow you to maintain contact with your new allies.\n\nAs you set course for Earth, you reflect on the incredible journey you've just completed. Humanity is no longer alone in the universe - and you have been chosen to guide them into this new era.\n\nYour adventure has only just begun...\n\n[END OF CHAPTER ONE]");
    ds_map_add(accept_invitation_scene, "choices", ["Restart the adventure", "Exit the game"]);
    ds_map_add(accept_invitation_scene, "outcomes", ["restart", "exit_game"]);
    ds_map_add(story_scenes, "accept_invitation", accept_invitation_scene);
    
    // Restart scene
    var restart_scene = ds_map_create();
    ds_map_add(restart_scene, "text", "You decide to experience the adventure again, perhaps making different choices this time...\n\nThe story begins anew...");
    ds_map_add(restart_scene, "choices", ["Start over"]);
    ds_map_add(restart_scene, "outcomes", ["start"]);
    ds_map_add(story_scenes, "restart", restart_scene);
}

// Start a new scene
function text_adventure_start_scene(scene_id) {
    if (!ds_map_exists(story_scenes, scene_id)) {
        show_debug_message("ERROR: Scene '" + scene_id + "' not found!");
        return;
    }
    
    current_scene = scene_id;
    var scene = story_scenes[? scene_id];
    
    current_text = scene[? "text"];
    text_position = 0;
    show_choices = false;
    current_choice = 0;
}

// Simple update function
function text_adventure_update() {
    text_timer++;
    
    // Simple typewriter effect
    if (text_timer >= 2 && text_position < string_length(current_text)) {
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
        var choices = scene[? "choices"];
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
            var outcomes = scene[? "outcomes"];
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

// Simple draw function
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
    var text_area_height = room_height / 2 - 50; // Half screen height minus margins
    
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
        y_pos += 25;
    }
    
    // Define choices area (bottom right section) - always draw border
    var choice_area_x = room_width / 2 + 50;
    var choice_area_y = room_height / 2 + 50;
    var choice_area_width = room_width / 2 - 100;
    var choice_area_height = room_height / 2 - 100;
    
    // Draw border around choices area
    draw_set_color(c_green);
    draw_rectangle(choice_area_x, choice_area_y, choice_area_x + choice_area_width, choice_area_y + choice_area_height, true);
    
    // Draw title for choices area
    draw_set_color(c_yellow);
    draw_text(choice_area_x + 20, choice_area_y + 5, "CHOICES");
    
    // Draw choices if ready
    if (show_choices) {
        var scene = story_scenes[? current_scene];
        var choices = scene[? "choices"];
        
        // Position choices inside the border
        var choice_x = choice_area_x + 20; // Add padding inside border
        var choice_y = choice_area_y + 50; // Add padding inside border + space for title
        
        for (var i = 0; i < array_length(choices); i++) {
            var choice_text = string(i + 1) + ". " + choices[i];
            if (i == current_choice) {
                draw_set_color(c_yellow); // Highlight selected choice
                draw_text(choice_x, choice_y + (i * 30), "   " + choice_text);
            } else {
                draw_set_color(c_green);
                draw_text(choice_x, choice_y + (i * 30), "  " + choice_text);
            }
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