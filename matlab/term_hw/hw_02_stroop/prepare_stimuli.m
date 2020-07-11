%% Prepare stimulus for the Stroop task

% Invoked by {run.m}

% * 2 words - "red" & "blue"
% * 2 colors - [255 0 0] & [0 0 255]
% * 4 stimulus - consistent & inconsistent (2 colors respectively)
% * 40 consistent and inconsistent conditions respectively (80 in total).
% * Randomly present the stimuli, each element can't be repeatedly
% presented more than twice.

% Build a 4 * 80 matrix (rows, colunms);
% 1st row: word id ("1", "2" for red and blue respectively);
% 2nd row: color id ("1", "2" for red and blue respectively）;
% 3rd row: is consistent (1 - yes; 0 - no);
% 4th：pressing key (1 - order1; 2 - order2);

%% Create texture

texture_opening = make_image_texture('instruction_opening.png', window);
texture_ending = make_image_texture('instruction_ending.png', window);

%% Create condition matrix

% There is a personal algorithm to generate the condition sequence that
% meet the requirement

% Create basic units

basic_chunk_12 = [1 1 2 1 2 2 1 2;...
    2 1 2 2 1 2 1 1;...
    2 2 1 2 1 1 2 1;...
    1 2 1 1 2 1 2 2];

unit_01 = [1 1 2 1 2 2 1 2;...
    1 2 1 1 2 1 2 2;...
    1 0 0 1 1 0 0 1];
unit_02 = [1 2 1 1 2 1 2 2;...
    1 1 2 1 2 2 1 2;...
    1 0 0 1 1 0 0 1];

% Generate four 8-column matrices and make it into a condition matrix
condition_seq = [];

for j=1:10
    
    % Generate an 8-column matrix
    
    % Randomly specify 1st to 3rd rows
    if randi(2) == 1
        temp_matrix = unit_01;
    else
        temp_matrix = unit_02;
    end
    % Append the last row
    temp_matrix = [temp_matrix;...
        basic_chunk_12(randi(4),:)];
    % Append the temp matrix
    condition_seq = [condition_seq temp_matrix];
end

%% Create empty data matrix

% Axis-1(Python NumPy representation) represents trials
% The first column represents subject id
% The second column represents gender
% The third color id (Not word id!!!) (1 for red and 2 for blue)
% The fourth column represents consistency (1 for yes and 2 for no)
% The fifth column represents reaction time (RT)
% The sixth column represents respond (1 for 'f' and 2 for 'j')
data = repmat([subject_id gender], 80, 1);
data = [data nan(80, 4)];
data = num2cell(data);