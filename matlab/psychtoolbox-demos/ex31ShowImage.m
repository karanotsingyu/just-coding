sca;
close all;
clearvars;

PsychDefaultSetup(2);

screens = Screen('Screens');
screenNumber = max(screens);

white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;
inc = white - grey;

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

ifi = Screen('GetFlipInterval', window);

[xCenter, yCenter] = RectCenter(windowRect);

Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

% Here we load in an image from file. This one is a image of rabbits that
% is included with PTB
% theImageLocation = [PsychtoolboxRoot 'PsychDemos' filesep...
%     'AlphaImageDemo' filesep 'konijntjes1024x768.jpg'];
theImageLocation = 'nisekoi.jpg';
% https://ww2.mathworks.cn/help/matlab/ref/imread.html
theImage = imread(theImageLocation);

% Get the size of the image
[s1, s2, s3] = size(theImage);

% Here we check if the image is too big to fit on the screen and abort if
% it is. See ImageRescaleDemo to see how to rescale an image.
if s1 > screenYpixels || s2 > screenYpixels
    disp('ERROR! Image is too big to fit on the screen');
    sca;
    return;
end

% Make the image into a texture
imageTexture = Screen('MakeTexture', window, theImage);

% Draw the image to the screen, unless otherwise specified PTB will draw
% the texture full size in the center of the screen. We first draw the
% image in its correct orientation.
% http://psychtoolbox.org/docs/Screen-DrawTexture
Screen('DrawTexture', window, imageTexture, [], [], 0);

Screen('Flip', window);

% Wait for two seconds
WaitSecs(2);

% Now fill the screen green
Screen('FillRect', window, [0 1 0]);

Screen('Flip', window);

WaitSecs(2);

% Draw the image to the screen for a second time this time upside down and
% drawn onto our updated blue background
Screen('DrawTexture', window, imageTexture, [], [], 180);

Screen('Flip', window);

WaitSecs(2);

sca;