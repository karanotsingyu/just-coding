close all;
clearvars;
sca;

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

% Lets write three lines of text, the first and second right after one
% another, and the third with a line space in between. To add line spaces
% we use the special characters "\n"

line1 = double('Hello World');
line2 = double('\n 这是第二行');
line3 = double('\n\n 这是第三行');

% Draw all the text in one go
Screen('TextSize', window, 64);
DrawFormattedText(window, [line1 line2 line3],...
    'center', screenYpixels * 0.25, white);

Screen('Flip', window);

KbStrokeWait;

sca;