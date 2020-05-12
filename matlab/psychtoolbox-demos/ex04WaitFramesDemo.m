% Clear the workspace and the screen
sca;
close all;
clearvars;

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Get the screen numbers. This gives us a number for each of the screens
% attached to our computer.
screens = Screen('Screens');

% To draw we select the maximum of these numbers. So in a situation where
% we have two screens attached to our monitor we will draw to the external
% screen.
screenNumber = max(screens);

% Define black and white (white will be 1 and black 0). This is because
% in general luminance values are defined between 0 and 1 with 255 steps in
% between. All values in Psychtoolbox are defined between 0 and 1
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

% Do a simply calculation to calculate the luminance value for grey. This
% will be half the luminance values for white.
grey = white / 2;

% Open an on screen window using PsychImaging and color it grey.
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);

% Measure the vertical refresh rate of the monitor
ifi = Screen('GetFlipInterval', window);

% Retreive the maximum priority number and set max priority
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);

% Here we use to a waitframes number greater then 1 to flip at a rate not
% equal to the monitors refresh rate. For this example, once per second,
% to the nearest frame
flipSecs = 1;
waitframes = round(flipSecs / ifi);

% disp('--------')
% disp(ifi) % 0.0167 = 1/60, namely 60 Hz
% disp(waitframes) % 60
% disp('--------')

% sca; % debug use

% Flip outside of the loop to get a time stamp
vbl = Screen('Flip', window);

% Run until a key is pressed
while ~KbCheck
    
    % Color the screen a random color
    Screen('FillRect', window, rand(1, 3));
    
    % Flip to the screen
    % The 'when' value is in seconds, 
    % e.g. vbl + 1 represents 1 frame per second (or 1Hz),
    % and vbl + 0.01 represents 100Hz orz...
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi); 

end

% Clear the screen.
sca;