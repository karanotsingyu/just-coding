%% A trial

% Must under the initiliaztion of run.m

%% Set the priority

Priority(top_priority_level);

%% Initilize getters

word_id = condition_seq(1, i_trial);
color_id = condition_seq(2, i_trial);
consistency = condition_seq(3, i_trial);
key_order = condition_seq(4, i_trial);

%% Present the fixation point for 0.5 second

% Set the size of the arms of the fixation cross
fix_cross_dim_pix = 20;

% Now we set the coordinates (these are all relative to zero we will let
% the drawing routine center the cross in the center of our monitor for us)
x_coords = [-fix_cross_dim_pix fix_cross_dim_pix 0 0];
y_coords = [0 0 -fix_cross_dim_pix fix_cross_dim_pix];
all_coords = [x_coords; y_coords];
% Specify line width (in pixels)
line_width_pix = 4;
% Draw the fixation cross in white, set it to the center of our screen and
% set good quality antialiasing
Screen('DrawLines', window, all_coords,...
    line_width_pix, white, [x_center y_center], 2);
% Flip to the screen and wait for 0.5 second
Screen('Flip', window);
WaitSecs(0.5);

%% Select within 3 seconds

% Flip to the screen and set the timestamp
vbl = Screen('Flip', window);
onset = vbl;
% Within 3 seconds
for i = 1:3 * frames_per_sec
    % Specify the word stimulus
    if word_id == 1
        presented_word = 'Red';
    elseif word_id == 2
        presented_word = 'Blue';
    end
    if color_id == 1
        presented_color = [255 0 0];
    elseif color_id == 2
        presented_color = [0 0 255];
    end
    % Present the word stimulus
    Screen('TextSize', window, 64);
    DrawFormattedText(window, presented_word,...
        'center', screen_y_pixels * 0.4, presented_color);
    % Specify the order
    if key_order == 1
        order_word = 'Yes  No';
    elseif key_order == 2
        order_word = 'No  Yes';
    end
    % Present the order
    Screen('TextSize', window, 32);
    DrawFormattedText(window, order_word,...
        'center', screen_y_pixels * 0.6, white);
    % Check the keyboard
    [keyIsDown, secs, keyCode] = KbCheck;
    % If press key F or key J, display and get the respond, the RT(ms) 
    % and then break the for-loop
    if keyCode(key_f)
        response = 1;
        RT = round((GetSecs - onset) * 1000);
        break
    elseif keyCode(key_j)
        response = 2;
        RT = round((GetSecs - onset) * 1000);
        break
    % If press key ESC, quit the scene, used for debugging
    % (this key is only available on MacOS)
    elseif keyCode(key_esc)
        disp('terminated by user')
        sca;
        break
    % Else if 3 seconds passed
    elseif i == 3 * frames_per_sec
        response = 'NA';
        RT = 'NA';
    end
    % Refresh the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
end
vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

%% If not in practice mode, record the data 

% Axis-1(Python NumPy representation) represents trials
% The first column represents subject id
% The second column represents gender
% The third column represents color id (Not word id!!!) (1 for red and 2 for blue)
% The fourth column represents consistency (1 for yes and 2 for no)
% The fifth column represents reaction time (RT)
% The sixth column represents respond (1 for 'f' and 2 for 'j')

if is_practice == false
    data{i_trial, 3} = color_id;
    data{i_trial, 4} = consistency;
    data{i_trial, 5} = RT;
    data{i_trial, 6} = response;
end