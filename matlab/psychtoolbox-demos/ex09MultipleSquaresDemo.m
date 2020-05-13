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

baseRect = [0 0 200 200];

% Screen X positions of our three rectangles
squareXpos = [screenXpixels * 0.25 screenXpixels * 0.5 screenXpixels * 0.75];
numSquares = length(squareXpos);

% Set the colors to Red, Green and Blue
allColors = [1 0 0; 0 1 0; 0 0 1];

% Make our rectangle coordinate
allRects = nan(4, 3);
for i = 1:numSquares
    allRects(:, i) = CenterRectOnPointd(baseRect, squareXpos(i), yCenter);
end

% Try some funny
Screen('FillRect', window, rand(1, 3));
% Draw the rect to the screen
Screen('FillRect', window, allColors, allRects);
% Try some funny
% Screen('FillRect', window, rand(1, 3));
% Flip to the screen
Screen('Flip', window);
% Try some funny
% Screen('FillRect', window, rand(1, 3));

KbStrokeWait;
sca;