sca;
close all;
clearvars;

PsychDefaultSetup(2);

screens = Screen('Screens');
screenNumber = max(screens);

white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, white);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

[xCenter, yCenter] = RectCenter(windowRect);

baseRect = [0 0 400 400];

% Screen X positions of our three rectangles
squareXpos = [xCenter - 200 xCenter + 200 xCenter];
squareYpos = [yCenter yCenter yCenter + 200];
numSquares = length(squareXpos);

% Set the colors to Red, Green and Blue, with the fourth value being the
% "alpha" value. This also takes a value between 0 and 1 just like a normal
% colour, however now 0 = totally transparent and 1 = totally opaque. Our
% RGB triplets are now RGBA values.
allColors = [1 0 0 1; 0 1 0 1; 0 0 1 0.5]';

allRects = nan(4, 3);
for i = 1:numSquares
    allRects(:, i) = CenterRectOnPointd(baseRect,...
        squareXpos(i), squareYpos(i));
end

Screen('FillRect', window, allColors, allRects);
Screen('Flip', window);
KbStrokeWait;
sca;