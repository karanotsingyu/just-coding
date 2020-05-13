% Normal initilization
sca;
close all;
clearvars;

PsychDefaultSetup(2);
rand('seed', sum(100 * clock));
screens = Screen('Screens');
screenNumber = max(screens);

white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);
[screenXpixels, screenYpixels] = Screen('WindowSize', window); % 1280 * 800
[xCenter, yCenter] = RectCenter(windowRect); % 640, 400

% Anti-aliasing
Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

% Use the meshgrid command to create our base dot coordinates. This will
% siimply be a grid of equally spaced coordinates in the X and Y
% dimensions, centered on 0, 0
% https://ww2.mathworks.cn/help/matlab/ref/meshgrid.html
dim = 10;
[x, y] = meshgrid(-dim:1:dim, -dim:1:dim);

% Here we scale the grid so that it is in pixel coordinates. We just scale
% it by the screen size so that it will fit. This is simply a 
% multiplication. Notive the "." before the multiplication sign. This
% allows us to multiply each number in the matrix by the scaling value.
% https://ww2.mathworks.cn/help/matlab/matlab_prog/array-vs-matrix-operations.html
% Why denominator equals to (dim * 2 + 2) i.e. 22 ?
% Maybe just arbitrarily set a comfortable scale... Nothing special
pixelScale = screenYpixels / (dim * 2 + 2); % 36.3636 in my Mac
x = x .* pixelScale;
y = y .* pixelScale;

% Calculate the number of dots
% https://ww2.mathworks.cn/help/matlab/ref/numel.html
numDots = numel(x);

% Make the matrix of positions for the dots. This need to be a two row
% vector. The top row will be the X coordinate of the dot and the bottom
% row the Y coordinate of the dot. Each column represents a single dot. For
% help see: help reshape
% https://ww2.mathworks.cn/help/matlab/ref/reshape.html
dotPositionMatrix = [reshape(x, 1, numDots); reshape(y, 1, numDots)];

% We can define a center for the dot coordinates to be relative to. Here
% we set the centre to be the centre of the screen
dotCenter = [xCenter yCenter];

% Set the color of our dot to be random i.e. a random number between 0 and
% 1
dotColors = rand(3, numDots) .* white;

% Set the size of the dots randomly between 10 and 30 pixels
dotSizes = rand(1, numDots) .* 20 + 10;

% Draw all of our dots to the screen in a single line of code
% http://psychtoolbox.org/docs/Screen-DrawDots
Screen('DrawDots', window, dotPositionMatrix,...
    dotSizes, dotColors, dotCenter, 2);

% Flip to the screen. This command basically draws all of our previous
% command onto the screen. See later demos in the animation section on more
% timing details. And how to demos in this section on how to draw multiple
% rects at once.
Screen('Flip', window);

% Normal ending
KbStrokeWait;
sca;

% disp('------')
% disp(x)
% disp(y)
% disp(white)
% disp('------')