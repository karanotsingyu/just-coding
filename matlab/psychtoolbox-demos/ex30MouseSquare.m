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

% Here we set the initial position of the mouse to be in the centre of the
% screen
SetMouse(xCenter, yCenter, window);

% We now set the squares initial position to the centre of the screen
sx = xCenter;
sy = yCenter;
centeredRect = CenterRectOnPointd(baseRect, sx, sy);

% Offset toggle. This determines if the offset between the mouse and centre
% of the square has been set. We use this so that we can move the position
% of the square around the screen without it "snapping" its centre to the
% position of the mouse
offsetSet = 0;

vbl = Screen('Flip', window);
waitframes = 1;

topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);

while ~KbCheck
    
    % Get the current position of the mouse
    [mx, my, buttons] = GetMouse(window);
    
    % Find the central position of the square
    [cx, cy] = RectCenter(centeredRect);
    
    % See if the mouse cursor is inside the square
    inside = IsInRect(mx, my, centeredRect);
    
    % If the mouse cursor is inside the square and a mouse button is being
    % pressed and the offset has not been set, set the offset and signal
    % that it has been set
    if inside == 1 && sum(buttons) > 0 && offsetSet == 0
        dx = mx - cx;
        dy = my - cy;
        offsetSet = 1;
    end
    
    % If we are clicking on the square allow its position to be modified by
    % moving the mouse, correcting for the offset between the centre of the
    % square and the mouse position
    if inside == 1 && sum(buttons) > 0
        sx = mx - dx;
        sy = my - dy;
    end
    
    % Center the rectangle on its new screen position
    centeredRect = CenterRectOnPointd(baseRect, sx, sy);
    
    Screen('FillRect', window, red, centeredRect);
    Screen('DrawDots', window, [mx my], 10, white, [], 2);
    
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
    
    % Check to see if the mouse button has been released and if so reset
    % the offset cue
    if sum(buttons) <= 0
        offsetSet = 0;
    end
    
end

sca;