sca;
close all;
clearvars;

PsychDefaultSetup(2);

screens = Screen('Screens');
screenNumber = max(screens);

white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

% Let's change the background color
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, white);

[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);

baseRect = [0, 0, 200, 250];

% For Ovals we set a maximum diameter up to which it is perfect for
maxDiameter = max(baseRect) * 1.01;

% Center the rectangle on the centre of the screen
centeredRect = CenterRectOnPointd(baseRect, xCenter, yCenter);

rectColor = [1 0 0];

Screen('FillOval', window, rectColor, centeredRect, maxDiameter);

Screen('Flip', window);
KbStrokeWait;
sca;