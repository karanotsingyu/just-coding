% Normal acts for initialization
sca;
close all;
clearvars

PsychDefaultSetup(2);

screens = Screen('Screens');
screenNumber = max(screens);

white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);

% Get the size of the on screen window
% http://psychtoolbox.org/docs/Screen-WindowSize
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% disp('------')
% disp([screenXpixels, screenYpixels]) % 1280x800 in my Mac
% disp('------')

% Query the frame duration, or...
% Measure the vertical refresh rate of the monitor
ifi = Screen('GetFlipInterval', window); % 1/60 in my Mac

% Setup the text type for the window
Screen('TextFont', window, 'Ariel');
Screen('TextSize', window, 50);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowsRect);

% Here we set the initial position of the mouse to a random position on the
% screen
SetMouse(round(rand * screenXpixels), round(rand * screenYpixels), window)

% Set the mouse to the top left of the screen to start with
SetMouse(0, 0, window)

% Loop the animation until a key is pressed
while ~KbCheck
    
    % Get the current position of the mouse
    [x, y, buttons] = GetMouse(window);
    
    % We clamp the values at the screen in X and Y
    % incase people have two monitors connected. This is all we want to
    % show for this basic demo.
    x = min(x, screenXpixels);
    y = min(y, screenYpixels);
    
    % Construct our text string
    textString = ['Mouse at X pixel ' num2str(round(x))...
        ' and Y pixel ' num2str(round(y))];
    
    % Text output of mouse position draw in the centre of the screen
    DrawFormattedText(window, textString, 'center', 'center', white);
    
    % Draw a white dot where the mouse cursor is
    Screen('DrawDots', window, [x y], 10, white, [], 2);
    
    % Flip to the screen
    Screen('Flip', window);

end

% Normal ending
sca;

disp('------')
disp([xCenter, yCenter]) %  in my Mac
disp('------') 