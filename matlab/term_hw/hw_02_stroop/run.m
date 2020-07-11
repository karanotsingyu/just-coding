%% Stroop task

%% ====================================================================
%                             Initialize PTB
% =====================================================================

% --------------—------------------------------------------------------
% Something basic
% --------------—------------------------------------------------------

sca;
close all;
clearvars;
rand('seed', sum(100 * clock));

% --------------—------------------------------------------------------
% Subject information registration
% --------------—------------------------------------------------------

% Pop an input dialog box asking for subject ID
% (use questionnaire to collect gender and age information)
subject_id = inputdlg('Enter your subject ID (e.g. "01")');
subject_id = subject_id{1};
gender = inputdlg('Enter your gender ("01" for male and "02" for female)');
gender = gender{1};

% --------------—------------------------------------------------------
% Make PTB screen settings
% --------------—------------------------------------------------------

% PTB preference
Screen('Preference', 'SkipSyncTests', 1);
% Specify the screen
screen_number = max(Screen('Screens'));
% Define black and white
white = WhiteIndex(screen_number);
black = BlackIndex(screen_number);
% Background color
grey = [165 165 165];
% Open the window and color it grey
[window, windowRect] = PsychImaging('OpenWindow', screen_number, grey, [0 0 1280 720]);
% Get the size of the on screen window
[screen_x_pixels, screen_y_pixels] = Screen('WindowSize', window);
% Get the center position of the window
[x_center, y_center] = RectCenter(windowRect);
% Retreive the maximum priority number
top_priority_level = MaxPriority(window);
% Anti-aliasing
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
% Defensive debugging
disp('defensive debugging: screen setting completed')

% --------------—------------------------------------------------------
% Make PTB accurate timing settings
% --------------—------------------------------------------------------

% Measure the vertical refresh rate of the monitor
ifi = Screen('GetFlipInterval', window);
% Interstimulus interval time in seconds and frames
isi_time_secs = 1;
frames_per_sec = round(isi_time_secs / ifi);
% Number of frames to wait before re-drawing
waitframes = 1;
% Defensive debugging
disp('defensive debugging: timing setting completed')

% --------------—------------------------------------------------------
% Make PTB keyboard settings
% --------------—------------------------------------------------------

% Unify key names settings
KbName('UnifyKeyNames')
% The available keys to press
% Escape: Quit the program (esp. for debugging)
% (this key code is only available on MacOS)
key_esc = KbName('ESCAPE');
% S: Start
key_s = KbName('s');
% F: Select left bandit
key_f = KbName('f');
% J: Select right bendit
key_j = KbName('j');
% Defensive debugging
disp('defensive debugging: keyboard setting completed')

%% ====================================================================
%               Prepare stimuli and start the Program
% =====================================================================

% Prepare stimuli @{prepare_stimuli.m}
prepare_stimuli;
% Display the opening instruction text
Screen('DrawTexture', window, texture_opening);
Screen('Flip', window);
% Press key S to continue
wait_until_press(key_s);
% No practicing task this time
is_practice = false;
% 80 trials @{trials.m}
for i_trial=1:80
    trial;
end
% Prepare notice ahead of time
disp('please wait... system is outputing data...')
% Display ending text for 10 seconds
Screen('DrawTexture', window, texture_ending);
Screen('Flip', window);
WaitSecs(10);
% Output xls data (!!!only for version R2019a and later!!!)
% Can't use xlswrite() in version R2019a of MacOSX, for more information: https://ww2.mathworks.cn/help/matlab/ref/xlswrite.html#mw_88a93783-cc81-4dbc-8146-46289887a551
writecell(data,[num2str([subject_id gender]) '.xls'])
% Quit the screen
sca;