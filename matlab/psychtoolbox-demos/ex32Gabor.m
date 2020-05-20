sca;
close all;
clearvars;

PsychDefaultSetup(2);

screenNumber = max(Screen('Screens'));

white = WhiteIndex(screenNumber);
grey = white / 2;

Screen('Preference', 'SkipSyncTests', 2);

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey, [], 32, 2,...
    [], [], kPsychNeed32BPCFloat);

%--------------------
% Gabor information
%--------------------

% Dimension of the region where will draw the Gabor in pixels
gaborDimPix = windowRect(4) / 2;

% Sigma of Gaussian
sigma = gaborDimPix / 7;

% Obvious Parameters... Nope
orientation = 0;
contrast = 0.8;
aspectRatio = 1.0;
phase = 0;

% Spatial Frequency (Cycles Per Pixel)
% One Cycle = Grey-Black-Grey-White-Grey i.e. One Black and One White Lobe
numCycles = 5;
freq = numCycles / gaborDimPix;

% Build a procedural gabor texture (Note: to get a "standard" Gabor patch
% we set a grey background offset, disable normalisation, and set a
% pre-contrast multiplier of 0.5.
% For full details see:
% https://groups.yahoo.com/neo/groups/psychtoolbox/conversations/topics/9174
backgroundOffset = [0.5 0.5 0.5 0.0];
disableNorm = 1;
preContrastMultiplier = 0.5;
gabortex = CreateProceduralGabor(window, gaborDimPix, gaborDimPix, [],...
    backgroundOffset, disableNorm, preContrastMultiplier);

% Randomise the phase of the Gabors and make a properties matrix.
propertiesMat = [phase, freq, sigma, contrast, aspectRatio, 0, 0, 0];

%------------------------------------------
%    Draw stuff - button press to exit
%------------------------------------------

% Draw the Gabor. By default PTB will this in the center of the screen for
% us.
Screen('DrawTextures', window, gabortex, [], [], orientation, [], [], [], [],...
    kPsychDontDoRotation, propertiesMat');

Screen('Flip', window);

KbWait;

sca;