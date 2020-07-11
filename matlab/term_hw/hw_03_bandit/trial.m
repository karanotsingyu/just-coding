%% A trial

% Must under the initiliaztion of {run.m}

%% Set the priority

Priority(top_priority_level);

%% Initilize getters

% position_id (1 for green at left and 2 for orange at left);
pos_id = condition_seq(1, i_trial);
% Bonus
bonus_green = condition_seq(2, i_trial);
bonus_orange = condition_seq(3, i_trial);

%% Present the fixation point for 0.75 second

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
    line_width_pix, black, [x_center y_center], 2);
% Flip to the screen and wait for 0.5 second
Screen('Flip', window);
WaitSecs(0.75);

%% Select within 2 seconds

% Flip to the screen and set the timestamp
vbl = Screen('Flip', window);
onset = vbl;
% Within 3 seconds
for i = 1:3 * frames_per_sec
    % Specify the position and bonus
    % If pos_id equals 1, green left orange right
    if pos_id == 1
        texture_left = texture_green;
        texture_right = texture_orange;
        bonus_left = bonus_green;
        bonus_right = bonus_orange;
    % Else, orange left green right
    else
        texture_left = texture_orange;
        texture_right = texture_green;
        bonus_left = bonus_orange;
        bonus_right = bonus_green;
    end
    % Present the position
    Screen('DrawTexture', window, texture_left, [], destination_rect_left);
    Screen('DrawTexture', window, texture_right, [], destination_rect_right);
    % Check the keyboard
    [keyIsDown, secs, keyCode] = KbCheck;
    % If press key F or key J, display and get the respond, the RT(ms) 
    % and then break the for-loop
    if keyCode(key_f)
        response = 1;
        RT = round((GetSecs - onset) * 1000);
        bonus = bonus_left;
        rect_x_pos = x_position_left;
        break
    elseif keyCode(key_j)
        response = 2;
        RT = round((GetSecs - onset) * 1000);
        bonus = bonus_right;
        rect_x_pos = x_position_right;
        break
    % If press key ESC, quit the scene, used for debugging
    % (this key is only available on MacOS)
    elseif keyCode(key_esc)
        disp('======================')
        disp('= Terminated by user =')
        disp('======================')
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

%% Display the hollow rect for 0.5s

current_rect = CenterRectOnPointd([0 0 200 200], rect_x_pos, y_center);
Screen('FrameRect', window, [255 0 0], current_rect, 6);
Screen('Flip', window);
WaitSecs(0.5);

%% Present the feedback for 1s

Screen('TextSize', window, 64);
DrawFormattedText(window, num2str(bonus),...
    rect_x_pos, screen_y_pixels * 0.5, [0 0 0]);
Screen('Flip', window);
WaitSecs(1);

%% If not in practice mode, record the data 

if is_practice == false
    data{i_trial, 3} = RT;
    data{i_trial, 4} = response;
    data{i_trial, 5} = bonus;
end