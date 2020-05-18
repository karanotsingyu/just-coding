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

Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

ifi = Screen('GetFlipInterval', window);

% We will be drawing some text so here we set the size we want the text
% to be
Screen('TextSize', window, 30);

% The available keys to press
escapeKey = KbName('ESCAPE');
upKey = KbName('UpArrow');
downKey = KbName('DownArrow');
leftKey = KbName('LeftArrow');
rightKey = KbName('RightArrow');

[xCenter, yCenter] = RectCenter(windowRect);

baseRect = [0 0 200 300];
rectColor = [0.5 0.5 0.5];

squareX = xCenter;
squareY = yCenter;

dotColors = [0 1 0; 1 0 0; 0 0 1];

pixelsPerPress = 10;

vbl = Screen('Flip', window);
waitframes = 1;

topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);

% The cue which determines whether we exit the demo
exitDemo = false;

% Loop the animation until the escape key is pressed
while exitDemo == false
    
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
    % the screen. Here when the rectangles edges hit the screen then it it
    % will not move off the screen at all
    if squareX < baseRect(3) / 2
        squareX = baseRect(3) / 2;
    elseif squareX > screenXpixels - baseRect(3) / 2
        squareX = screenXpixels - baseRect(3) / 2;
    end
    
    if squareY < baseRect(4) / 2
        squareY = baseRect(4) / 2;
    elseif squareY > screenYpixels - baseRect(4) / 2
        squareY = screenYpixels - baseRect(4) / 2;
    end
    
    centeredRect = CenterRectOnPointd(baseRect, squareX, squareY);
    Screen('FillRect', window, rectColor, centeredRect);
    
    % Draw dots that show the rects coordinates
    dotPositionMatrix = [squareX centeredRect(1) centeredRect(3);...
        squareY centeredRect(2) centeredRect(4)];
    Screen('DrawDots', window, dotPositionMatrix, 10, dotColors, [], 2);
    
    % Draw text in the upper portion of the screen with the default font in
    % white
    line1 = ['\n Top left corner (red dot): x = ' num2str(centeredRect(1))...
        ' y = ' num2str(centeredRect(2))];
    line2 = ['\n Bottom Right corner (blue dot): x = ' num2str(centeredRect(3))...
        ' y = ' num2str(centeredRect(4))];
    line3 = ['\n Rect Centre (green dot): x = ' num2str(squareX) ' y = ' num2str(squareY)];
    DrawFormattedText(window, [line1 line2 line3], 'center', 100, [1 1 1]);
    
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
    
end

sca;