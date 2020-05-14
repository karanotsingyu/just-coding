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
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);

Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

dim = 10;
[x, y] = meshgrid(-dim:1:dim, -dim:1:dim);

% Scale this by the distance in pixels we want between each dot
pixelScale = screenYpixels / (dim * 2 + 2);
x = x .* pixelScale;
y = y .* pixelScale;

% Calculate the number of dots
numDots = numel(x);

% Make the matrix of positions for the dots into two vectors
xPosVector = reshape(x, 1, numDots);
yPosVector = reshape(y, 1, numDots);

% We can define a center for the dot coordinates to be relative to. Here we
% set the centre to be the centre of the screen
dotCenter = [screenXpixels / 2 screenYpixels / 2];

% Set the color of our our dot to be random
dotColors = rand(3, numDots);

% Set the size of the dots randomly between 10 and 30 pixels
dotSizes = rand(1, numDots) .* 20 + 10;

% Our grid will oscilate with a sine wave function to the left and right of
% the screen. These are the parameters for the sine wave
% See: http://en.wikipedia.org/wiki/Sine_wave
amplitude = screenYpixels * 0.25;
frequency = 0.2;
angFreq = 2 * pi * frequency;
startPhase = 0;
time = 0;

% Sync us and get a time stamp
vbl = Screen('Flip', window);
waitframes = 1;

% Maximum priority level
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);

% Loop the animation until a key is pressed
while ~KbCheck
    
    % Position of the square on this frame
    gridPos = amplitude * sin(angFreq * time + startPhase);
    
    % Draw all of our dots to the screen in a single line of code adding
    % the sine oscilation to the X coordinates of the dots
    Screen('DrawDots', window, [xPosVector + gridPos; yPosVector],...
        dotSizes, dotColors, dotCenter, 2);
    
    % Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
    
    % Increment the time
    time = time + ifi;
    
end

sca;