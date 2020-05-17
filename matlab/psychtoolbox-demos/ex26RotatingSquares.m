sca;
close all;
clearvars;

PsychDefaultSetup(2);

Screen('Preference', 'SkipSyncTests', 2);

screens = Screen('Screens');
screenNumber = max(screens);

white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);

topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);

ifi = Screen('GetFlipInterval', window);

% Our squares will have sides 150 pixels in length, as we are going to be
% rotating these around the origin using OpenGL commands we use -75 to +75
% for the X and Y coordinates
dim = 150 / 2;
baseRect = [-dim -dim dim dim];

numRects = 3;

% We will randomise the initial rotation angles of the squares. OpenGL uses
% Degrees (not Radians) in these commands, so our angles are in degrees
angles = rand(1, numRects) .* 360;

% We will set the rotations angles to increase by 1 degress on every frame
degPerFrame = 1;

% We position the squares in the middle of the screen in Y, spaced equally
% across the screen in X
posXs = [screenXpixels * 0.25 screenXpixels * 0.5 screenXpixels * 0.75];
posYs = ones(1, numRects) .* (screenYpixels / 2);

% Finally, we will set the colors of the squares to red, green and blue
colors = [1 0 0; 0 1 0; 0 0 1];

vbl = Screen('Flip', window);
waitframes = 1;

while ~KbCheck
    
    % With this basic way of drawing we have to translate each square frome
    % its screen position, to the coordinate [0 0], then rotate it , then
    % move it back to its screen position.
    % This is rather inefficient when drawing many rectangles at high
    % refresh rates. But will work just fine for simple drawing tasks.
    % For a much more efficient way of drawing rotated squares and
    % rectangles have a look at the texture tutorials
    for i = 1:numRects
        
        % Get the current squares position ans rotation angle
        posX = posXs(i);
        posY = posYs(i);
        angle = angles(i);
        
        % Translate, rotate, re-translate and then draw our square
        Screen('glPushMatrix', window);
        Screen('glTranslate', window, posX, posY);
        Screen('glRotate', window, angle, 0, 0);
        Screen('glTranslate', window, -posX, -posY);
        Screen('FillRect', window, colors(i,:),...
            CenterRectOnPoint(baseRect, posX, posY));
        Screen('glPopMatrix', window)
        
    end
    
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
    
    angles = angles + degPerFrame;
    
end

sca;