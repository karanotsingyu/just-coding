sca;
close all;
clearvars;

PsychDefaultSetup(2);

screens = Screen('Screens');
screenNumber = max(screens);

white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

ifi = Screen('GetFlipInterval', window);

[xCenter, yCenter] = RectCenter(windowRect);

baseRect = [0 0 200 200];

red = [1 0 0];
blue = [0 0 1];

% Here we set the initial position
SetMouse(xCenter, yCenter, window);

vbl = Screen('Flip', window);
waitframes = 1;

topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);

while ~KbCheck
    
    % Get the current position of the mouse
    [x, y, buttons] = GetMouse(window);
    
    centeredRect = CenterRectOnPointd(baseRect, xCenter, yCenter);
    
    % See if the mouse cursor is inside the square
    inside = IsInRect(x, y, centeredRect);
    
    % Set the color of the square to be red if the mouse is inside it or
    % blue if the mouse is outside it
    if inside == 1
        rectColor = red;
    elseif inside == 0
        rectColor = blue;
    end
    
    Screen('FillRect', window, rectColor, centeredRect);
    Screen('DrawDots', window, [x y], 10, white, [], 2);
    
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
    
end

sca;