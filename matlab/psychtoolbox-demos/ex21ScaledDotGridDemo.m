sca;
close all;
clearvars;

PsychDefaultSetup(2);

screens = Screen('Screens');
screenNumber = max(screens);

white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);

Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

ifi = Screen('GetFlipInterval', window);

dim = 10;
[x, y] = meshgrid(-dim:1:dim, -dim:1:dim);

pixelScale = screenYpixels / (dim * 2 + 2);
x = x .* pixelScale;
y = y .* pixelScale;

numDots = numel(x);

xPosVector = reshape(x, 1, numDots);
yPosVector = reshape(y, 1, numDots);

% We can define a center for the dot coordinates to be relative to. Here we
% set the centre to be the centre of the screen
dotCenter = [screenXpixels / 2 screenYpixels / 2];

% Set the color of our dot to be random
dotColors = rand(3, numDots);

maxDotSize = 25;

amplitude = 1;
frequency = 0.05;
angFreq = 2 * pi * frequency;
startPhase = 0;
time = 0;

% Sync us and get a time stamp
vbl = Screen('Flip', window);
waitframes = 1;

% Maximum priority level
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);

while ~KbCheck
    
    % Scale the grid coordinates
    scaleFactor = abs(amplitude * sin(angFreq * time + startPhase));
    
    % Scale the dot size. Here we limit the minimum dot size to one pixel
    % by using the max function as PTB won't allow the dot size to scale to
    % zero (sensibly, as you'd be drawing no dots at all)
    thisDotSize = max(1, maxDotSize .* scaleFactor);
    
    % Draw all of our dots to the screen in a single line of code adding
    % the sine oscilation to the X coordinates of the dots
    Screen('DrawDots', window, [xPosVector; yPosVector] .* scaleFactor,...
        thisDotSize, dotColors, dotCenter, 2);
    
    % FLip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
    
    % Increment the time
    time = time + ifi;

end

sca;