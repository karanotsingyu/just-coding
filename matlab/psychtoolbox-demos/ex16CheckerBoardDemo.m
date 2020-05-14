sca;
close all;
clearvars;

PsychDefaultSetup(2);

screens = Screen('Screens');
screenNumber = max(screens);

white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
[xCenter, yCenter] = RectCenter(windowRect);

% Make a base Rect of 200 by 200 pixels
dim = 50;
baseRect = [0 0 dim dim];

% Make the coordinates for our grid of squares
[xPos, yPos] = meshgrid(-2:1:2, -2:1:2);

% Calculate the number of squares and reshape the matrices of coordinates
% into a vector
[s1, s2] = size(xPos);
numSquares = s1 * s2;

xPos = reshape(xPos, 1, numSquares);
yPos = reshape(yPos, 1, numSquares);

% Scale the grid spacing to the size of our squares and centre
xPosLeft = xPos .* dim + screenXpixels * 0.25;
yPosLeft = yPos .* dim + yCenter;

xPosRight = xPos .* dim + screenXpixels * 0.75;
yPosRight = yPos .* dim + yCenter;

% Set the colors of each of our squares
% Key statements of making chessboards
multiColors = rand(3, numSquares);
bwColors = repmat(eye(2), 3, 3);
bwColors = bwColors(1:end-1, 1:end-1);
bwColors = reshape(bwColors, 1, numSquares);
bwColors = repmat(bwColors, 3, 1);

% Make our rectangle coordinates
allRectsLeft = nan(4, 3);
allRectsRight = nan(4, 3);
for i = 1:numSquares
    allRectsLeft(:, i) = CenterRectOnPointd(baseRect,...
        xPosLeft(i), yPosLeft(i));
    allRectsRight(:, i) = CenterRectOnPointd(baseRect,...
        xPosRight(i), yPosRight(i));
end

Screen('FillRect', window, [multiColors bwColors],...
    [allRectsLeft allRectsRight]);

Screen('Flip', window);
KbStrokeWait;
sca;