close all;
clearvars;
sca

PsychDefaultSetup(2);

screens = Screen('Screens');
screenNumber = max(screens);

black = BlackIndex(screenNumber);
white = WhiteIndex(screenNumber);
grey = white / 2;

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);

Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);

% Draw text in the upper portion of the screen with the default font in red
Screen('TextSize', window, 70);
DrawFormattedText(window, 'Hello World', 'center',...
    screenYpixels * 0.25, [1 0 0]);

% Draw text in the middle of the screen in Courier in white
Screen('TextSize', window, 80);
Screen('TextFont', window, 'Courier');
DrawFormattedText(window, 'Hello World', 'center', 'center', white);

% Draw text in the bottom of the screen in Times in blue
Screen('TextSize', window, 90);
Screen('TextFont', window, 'Times');
DrawFormattedText(window, 'Hello World', 'center',...
    screenYpixels * 0.75, [0 0 1]);

Screen('Flip', window);

KbStrokeWait;
sca;