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

ifi = Screen('GetFlipInterval', window);

[xCenter, yCenter] = RectCenter(windowRect);

baseRect = [0 0 200 200];

topColor = [1 0 0];
bottomColor = [0 0 1];

amplitude = screenXpixels * 0.25;
frequency = 0.2;
angFreq = 2 * pi * frequency;
time = 0;

% Our two squares will be pi out of phase
startPhaseOne = 0;
startPhaseTwo = pi;

% Sync us and get a time stamp
vbl = Screen('Flip', window);
waitframes = 1;

topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);

while ~KbCheck
    
    % Position of the two squares on this frame
    xposOne = amplitude * sin(angFreq * time + startPhaseOne);
    xposTwo = amplitude * sin(angFreq * time + startPhaseTwo);
    
    % Add this position to the screen center coordinate. This is the point
    % we want our squares to oscillate around
    squareXposOne = xCenter + xposOne;
    squareXposTwo = xCenter + xposTwo;
    
    % Center the rectangle on the centre of the screen
    centeredRectOne = CenterRectOnPointd(baseRect, squareXposOne,...
        screenYpixels * 0.25);
    centeredRectTwo = CenterRectOnPointd(baseRect, squareXposTwo,...
        screenYpixels * 0.75);
    
    % Draw the rect to the screen
    Screen('FillRect', window, [topColor' bottomColor'],...
        [centeredRectOne' centeredRectTwo']);
    
    % Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
    
    % Increment the time
    time = time + ifi;

end

sca;