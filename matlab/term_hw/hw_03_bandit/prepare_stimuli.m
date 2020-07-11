%% Prepare stimulus for the bandit task

% Invoked by {run.m}

% Build a 3 * trial_num matrix (rows, colunms);
% 1st row: position_id ("1", "2" for green and orange at left place respectively);
% 2nd row: bonus for the green bandit, following N(20,3);
% 3rd row: bonus for the orange bandit, following N(15,3);

%% Create stimuli

% Make texture
texture_opening = make_image_texture('instruction_opening.png', window);
texture_ending = make_image_texture('instruction_ending.png', window);
texture_green = make_image_texture('bandit_green.jpg', window);
texture_orange = make_image_texture('bandit_orange.jpg', window);
% Specify the position of bandits and text
y_position = screen_y_pixels * 0.5;
x_position_left = screen_x_pixels * 0.3;
x_position_right = screen_x_pixels * 0.7;
% Specify the destination
base_rect = [0 0 225 225];
destination_rect_left = CenterRectOnPointd(base_rect, x_position_left, y_position);
destination_rect_right = CenterRectOnPointd(base_rect, x_position_right, y_position);

%% Create condition matrix

if randi(2) == 1
    condition_seq = repmat([1 1 2 2], 1, 25);
else
    condition_seq = repmat([2 2 1 1], 1, 25);
end
reward_seq = [];
for i = 1:trial_num
    % Specify the reward based on Gaussian distribution
    reward_seq = [reward_seq [round(3*randn+20, 2), round(3*randn+15, 2)]'];
end
condition_seq = [condition_seq; reward_seq];

%% Create empty data matrix 

% Axis-1(Python NumPy representation) represents trials
% The first column represents subject id
% The second column represents gender
% The third column represents RT
% The fourth column represents decision
% The fifth column represents bonus
data = repmat([subject_id gender], trial_num, 1);
data = [data nan(trial_num, 3)];
data = num2cell(data);