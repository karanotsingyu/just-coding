sca;
close all;
clearvars;

PsychDefaultSetup(2);

screens = Screen('Screens');
screenNumber = max(screens);

white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);

% Make a base rect of 1/2 screen Y dimension for the black and white
% background squares, and 1/6 for the front grey squares. This will produce
% a standard simultaneous contrast illusion where the two smaller grey
% squares, altough the same luminance will appear different shades of grey
% due to being on different backgrounds. The one on the white background
% square will look darker then the one on the white background square.
backDim = screenYpixels / 2;
baseRectBack = [0 0 backDim backDim];

frontDim = screenYpixels / 6;
baseRectFront = [0 0 frontDim frontDim];

% Position the rectangles on the screen
backLeftRect = CenterRectOnPointd(baseRectBack,...
    xCenter - backDim / 2, yCenter);
backRightRect = CenterRectOnPointd(baseRectBack,...
    xCenter + backDim / 2, yCenter);

frontLeftRect = CenterRectOnPointd(baseRectFront,...
    xCenter - backDim / 2, yCenter);
frontRightRect = CenterRectOnPointd(baseRectFront,...
    xCenter + backDim / 2, yCenter);

allRects = [backLeftRect; backRightRect; frontLeftRect; frontRightRect]';

% We do the same of the colors of the rects. Put them in one matrix for
% drawing
allColors = [white white white; black black black;...
    grey grey grey; grey grey grey]';

% Draw all the rects in one line of code
Screen('FillRect', window, allColors, allRects);

Screen('Flip', window);
KbStrokeWait;
sca;