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

% The available keys to press
escapeKey = KbName('ESCAPE');
upKey = KbName('UpArrow');
downKey = KbName('DownArrow');
leftKey = KbName('LeftArrow');
rightKey = KbName('RightArrow');

[xCenter, yCenter] = RectCenter(windowRect);

baseRect = [0 0 200 200];
rectColor = [1 0 0];

% Set the initial position of the square to be in the centre of the screen
squareX = xCenter;
squareY = yCenter;

% Set the amount we want our square to move on each button press
pixelsPerPress = 10;

vbl = Screen('Flip', window);
waitframes = 1;

topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);

% This is the cue which determines whether we exit the demo
exitDemo = false;

% Loop the animation until the escape key is pressed
while exitDemo == false
    
    % Check the keyboard to see if a button has been pressed
    [keyIsDown, secs, keyCode] = KbCheck;
    
    % Depending on the button press, either move the position of the square
    % or exit the demo
    if keyCode(escapeKey)
        exitDemo = true;
    elseif keyCode(leftKey)
        squareX = squareX - pixelsPerPress;
    elseif keyCode(rightKey)
        squareX = squareX + pixelsPerPress;
    elseif keyCode(upKey)
        squareY = squareY - pixelsPerPress;
    elseif keyCode(downKey)
        squareY = squareY + pixelsPerPress;
    end
    
    % We set bounds to make sure our square doesn't go completely off of
    % the screen
    if squareX < 0
        squareX = 0;
    elseif squareX > screenXpixels
        squareX = screenXpixels;
    end
    
    if squareY < 0
        squareY = 0;
    elseif squareY > screenYpixels
        squareY = screenYpixels;
    end
    
    centeredRect = CenterRectOnPointd(baseRect, squareX, squareY);
    
    Screen('FillRect', window, rectColor, centeredRect);
    
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
    
end

sca;