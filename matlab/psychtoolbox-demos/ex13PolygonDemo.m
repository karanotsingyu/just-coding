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
[xCenter, yCenter] = RectCenter(windowRect);

% Number of sides for our polygon
numSides = 5;

% Angles at which our polygon vertices endpoints will be. We start at zero
% and then equally space vertex endpoints around the edge of a circle. The
% polygon is then defined by sequentially joining these end points.
% https://ww2.mathworks.cn/help/matlab/ref/linspace.html
anglesDeg = linspace(0, 360, numSides + 1);
anglesRad = anglesDeg * (pi / 180);
radius = 200;

% X and Y coordinates of the points defining out polygon, centred on the
% centre of the screen
yPosVector = sin(anglesRad) .* radius + yCenter;
xPosVector = cos(anglesRad) .* radius + xCenter;

rectColor = [1 0 0];

% Cue to tell PTB that the polygon is convex (concave polygons require much
% more processing
isConvex = 1;

% Draw the rect to the screen
Screen('FillPoly', window, rectColor, [xPosVector; yPosVector]', isConvex);

Screen('Flip', window);
KbStrokeWait;
sca;