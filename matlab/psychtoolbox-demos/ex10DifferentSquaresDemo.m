sca;
close all;
clear;

PsychDefaultSetup(2);
% ???
Screen('Preference', 'SkipSyncTests', 1);

screens = Screen('Screens');

screenNumber = max(screens);

white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);

baseRect = [0 0 200 200];

squareXpos = [screenXpixels * 0.25...
    screenXpixels * 0.5 screenXpixels * 0.75];
numSquares = length(squareXpos);

allColors = [1 0 0; 0 1 0; 0 0 1];

% Make a multiplier to modulate the size of our squares
sizeChanger = [0.7 1 1.3];

allRects = nan(4, 3);
for i = 1:numSquares
    allRects(:, i) = CenterRectOnPointd(baseRect .* sizeChanger(i),...
        squareXpos(i), yCenter);
end

Screen('FillRect', window, allColors, allRects);
Screen('Flip', window);
KbStrokeWait;
sca;