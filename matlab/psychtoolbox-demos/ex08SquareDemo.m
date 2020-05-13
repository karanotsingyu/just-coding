sca;
close all;
clearvars;

PsychDefaultSetup(2);

screens = Screen('Screens');
screenNumber = max(screens);
black = BlackIndex(screenNumber);

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);

% Make a base Rect of 200 by 200 pixels. This is the rect which defines the
% size of our square in pixels. Rects are rectangles, so the sides do not
% have to be the same length. The coordinates define the top left and
% bottom right coordinates of our rect [top-left-x top-left-y
% bottom-right-x bottom-right-y]. The easiest thing to do is set the first 
% two coordinates to 0, 
% then the last two numbers define the length of the rect in X and Y.
% The next line of code then centers the rect on a particular location of
% the screen.
baseRect = [0 0 200 200];
% If set [100 100 200 200], the Rect just becomes smaller and its position
% doesn't change
% If [300 100 200 200] and [300 300 200 200] etc., it will say
% Invalid Rect Argument: impossible rect values given

% Center the rectangle on the centre of the screen using fractional pixel
% values.
centeredRect = CenterRectOnPointd(baseRect, xCenter, yCenter);

% Set the color of our square to full red. Color is defined by red green
% and blue components (RGB). So we have three numbers which define our RGB
% values. The maximum number for each is 1 and the minimum 0.
rectColor = [1 0 0];

% Usual one
Screen('FillRect', window, rectColor, centeredRect);

Screen('Flip', window);

KbStrokeWait;

sca;