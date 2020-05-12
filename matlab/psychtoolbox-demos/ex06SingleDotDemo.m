sca;
close all;
clearvars;

PsychDefaultSetup(2);

% Seed the random number generator. Here we use the an older way to be
% compatible with older systems. Newer syntax would be rng('shuffle').
% For help see: help rand
% https://ww2.mathworks.cn/help/matlab/ref/rand.html
% https://ww2.mathworks.cn/help/matlab/math/updating-your-random-number-generator-syntax.html
% Maybe same as random.seed() in Python
rand('seed', sum(100 * clock));

% Normally initialization
screens = Screen('Screens');
screenNumber = max(screens);

white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);

[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);

% Enable alpha blending for anti-aliasing
% http://psychtoolbox.org/docs/Screen-BlendFunction
% For help see: Screen BlendFunction
% Also see: Chapter 6 of the OpenGL programming guide
Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

% Set the color of our dot to full red. Color is defined by red green and
% blue components (RGB). So we have three numbers which define our RGB
% values. The maximum number for each is 1 and the minimum 0. So, "full
% red" is [1 0 0]. "Full green" [0 1 0] and "full blue" [0 0 1]. Play
% around with these numbers and see the result.
dotColor = [1 0 0];

% Determine a random X and Y position for our dot. NOTE: As dot position is
% randomised each time you run the script the output will show the dot in a
% different position. Similarly, when you run the script the position of
% the dot will be randomised each time. NOTE also, that if the dot is drawn
% at the edge of the screen some of it might not be visible.
dotXpos = rand * screenXpixels;
dotYpos = rand * screenYpixels;

% Dot size in pixels
dotSizePix = 20;

% Draw the dot to the screen. For information on the command used in this
% line type "Screen DrawDots?" at the command line (without the brackets)
% and press enter. Here we used good antialiasing to get nice smooth edges
Screen('DrawDots', window, [dotXpos dotYpos], dotSizePix, dotColor, [], 2);

% Flip to the screen. This command basically draws all of our previous
% commands onto the screen. See later demos in the animation section on
% more timing details. And how to demos in this section on how to draw
% multiple rects at once.
Screen('Flip', window);

% Now we have drawn to the screen we wait for a keyboard button press (any
% key) to terminate the demo.
% 
KbStrokeWait;

% Normal ending
sca;