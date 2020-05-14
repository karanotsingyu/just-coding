% Clear the workspace and the screen
sca;
close all;
clearvars;

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Get the screen numbers
screens = Screen('Screens');

% Draw to the external screen if avaliable
screenNumber = max(screens);

% Define black and white
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

ifi = Screen('GetFlipInterval', window);

[xCenter, yCenter] = RectCenter(windowRect);

baseRect = [0 0 200 200];
rectColor = [1 0 0];

amplitude = screenXpixels * 0.25;
frequency = 0.2;
angFreq = 2 * pi * frequency;
startPhase = 0;
time = 0;

vbl = Screen('Flip', window);
waitframes = 1;

topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);

while ~KbCheck
    
    xpos = amplitude * sin(angFreq * time + startPhase);
    
    squareXpos = xCenter + xpos;
    
    centeredRect = CenterRectOnPointd(baseRect, squareXpos, yCenter);
    
    Screen('FillRect', window, rectColor, centeredRect);
    
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
    
    time = time + ifi;
    
end

sca;