

%% Working Memory Trial 1 %%

%Tests location of the Gabor shown two trials ago%
%This % Clear the workspace
close all;
clear;
sca;

% Setup PTB with some default values
PsychDefaultSetup(2);

% Seed the random number generator. Here we use the an older way to be
% compatible with older systems. Newer syntax would be rng('shuffle'). Look
% at the help function of rand "help rand" for more information
rand('seed', sum(100 * clock));

% Set the screen number to the external secondary monitor if there is one
% connected
screenNumber = max(Screen('Screens'));

% Define black, white and grey
white = WhiteIndex(screenNumber);
grey = white / .5;
black = BlackIndex(screenNumber);

% Open the screen
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey, [], 32, 2,...
    [], [],  kPsychNeed32BPCFloat);

% Flip to clear
Screen('Flip', window);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

% Set the text size
Screen('TextSize', window, 40);

% Query the maximum priority level
topPriorityLevel = MaxPriority(window);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

%--------------------
% Gabor information
%--------------------

% Dimension of the region where will draw the Gabor in pixels
gaborDimPix = 200;

% Sigma of Gaussian
sigma = gaborDimPix / 7;

% Obvious Parameters
orientation = 90;
contrast = 1;
aspectRatio = 1.0;

% Spatial Frequency (Cycles Per Pixel)
% One Cycle = Grey-Black-Grey-White-Grey i.e. One Black and One White Lobe
numCycles = 8;
freq = numCycles / gaborDimPix;

% Build a procedural gabor texture
gabortex = CreateProceduralGabor(window, gaborDimPix, gaborDimPix, [],...
    [1 0.5 0.5 0.0], 1, 0.5);

% We will be displaying our Gabors either above or below fixation by 250
% pixels. We therefore have to determine these two locations in screen
% coordianates.
pixShift = 250;
xPos = [xCenter xCenter xCenter xCenter];
yPos = [yCenter - pixShift yCenter + pixShift yCenter yCenter yCenter - pixShift yCenter + pixShift yCenter yCenter];

% Count how many Gabors there are (4 for this demo)
nGabors = numel(xPos);

% Make the destination rectangles for  the Gabors in the array i.e.
% rectangles the size of our Gabors cenetred above an below fixation.
baseRect = [0 0 gaborDimPix gaborDimPix 0 0 gaborDimPix gaborDimPix ];
allRects = nan(8, nGabors);
for i = 1:nGabors
    allRects(:, i) = CenterRectOnPointd(baseRect, xPos(i), yPos(i));
end

% Randomise the phase of the Gabors and make a properties matrix.
phaseLine = rand(1, nGabors) .* 360;
propertiesMat = repmat([NaN, freq, sigma, contrast,...
    aspectRatio, 0, 0, 0], nGabors, 1);
propertiesMat(:, 1) = phaseLine';

% Set the locations for the methods of constant stimuli. We will center
% the range around zero.
baseOrientation = 0;
numSteps = 7;
stimValues = baseOrientation;

% Now we set the number of times we want to do each condition, then make a
% full condition vector and then shuffle it. This will randomly order the
% orientation we present our Gabor with on each trial.
numRepeats = 3;
condVector = Shuffle(repmat(stimValues, 1, numRepeats));

% Calculate the number of trials
numTrials = numel(condVector);

% Make a vector to record the response for each trial
respVector = zeros(1, numSteps);

% Make a vector to count how many times we present each stimulus. This is a
% good check to make sure we have done things right and helps us when we
% input the data to plot anf fit our psychometric function
countVector = zeros(1, numSteps);

%----------------------------------------------------------------------
%                       Timing Information
%----------------------------------------------------------------------

% Presentation Time for the Gabor in seconds and frames
presTimeSecs = 0.2;
presTimeFrames = round(presTimeSecs / ifi);

% Interstimulus interval time in seconds and frames
isiTimeSecs = 1;
isiTimeFrames = round(isiTimeSecs / ifi);

% Numer of frames to wait before re-drawing
waitframes = 1;


%----------------------------------------------------------------------
%                       Keyboard information
%----------------------------------------------------------------------

% Define the keyboard keys that are listened for. We will be using the left
% and right arrow keys as response keys for the task and the escape key as
% a exit/reset key
escapeKey = KbName('ESCAPE');
leftKey = KbName('LeftArrow');
rightKey = KbName('RightArrow');
upKey = KbName('UpArrow');
downKey= KbName('DownArrow');


%----------------------------------------------------------------------
%                       Experimental loop
%----------------------------------------------------------------------

% Animation loop: we loop for the total number of trials
for trial = 1:numTrials

    % Get the Gabor angle for this trial (negative values are to the right
    % and positive to the left)
    theOrientation = condVector(trial);

    % Randomise the side which the Gabor is displayed on
    side = round(rand) + 1;
    thisDstRect = allRects(:, side);

    % Change the blend function to draw an antialiased fixation point
    % in the centre of the screen
    Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

    % If this is the first trial we present a start screen and wait for a
    % key-press
    if trial == 1
        DrawFormattedText(window, 'Press Any Key To Begin! A texture will appear either in the \n\n top, bottom, left, or right part of the screen. Afterwards, an empty screen will \n\n come up and you will press the arrow associated with the orientation. ', 'center', 'center', black);
        Screen('Flip', window);
        KbStrokeWait;
    end

    % Flip again to sync us to the vertical retrace at the same time as
    % drawing our fixation point
    Screen('DrawDots', window, [xCenter; yCenter], 10, black, [], 2);
    vbl = Screen('Flip', window);

    % Now we present the isi interval with fixation point minus one frame
    % because we presented the fixation point once already when getting a
    % time stamp
    for frame = 1:isiTimeFrames - 1

        % Draw the fixation point
        Screen('DrawDots', window, [xCenter; yCenter], 10, black, [], 2);

        % Flip to the screen
        vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
    end

    % Now we draw the Gabor and the fixation point
    for frame = 1:presTimeFrames

        % Set the right blend function for drawing the gabors
        Screen('BlendFunction', window, 'GL_ONE', 'GL_ZERO');

        % Draw the Gabor
        Screen('DrawTextures', window, gabortex, [], thisDstRect, theOrientation, [], [], [], [],...
            kPsychDontDoRotation, propertiesMat');

        % Change the blend function to draw an antialiased fixation point
        % in the centre of the array
        Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

        % Draw the fixation point
        Screen('DrawDots', window, [xCenter; yCenter], 10, black, [], 2);

        % Flip to the screen
        vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
    end


    % Change the blend function to draw an antialiased fixation point
    Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

    % Draw the fixation point
    Screen('DrawDots', window, [xCenter; yCenter], 10, black, [], 2);

    % Flip to the screen
    vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

    % Now we wait for a keyboard button signaling the observers response.
    % The left arrow key signals a "left" response and the right arrow key
    % a "right" response. You can also press escape if you want to exit the
    % program
    respToBeMade = true;
    while respToBeMade
        [keyIsDown,secs, keyCode] = KbCheck;
        if keyCode(escapeKey)
            ShowCursor;
            sca;
            return
        elseif keyCode(leftKey)
            response = 1;
            respToBeMade = false;
        elseif keyCode(rightKey)
            response = 0;
            respToBeMade = false;
        elseif keyCode(upKey)
            response = 3;
            respToBeMade = false;
        elseif keyCode(downKey)
            response = 4;
            respToBeMade = false;

        end
    end

    % Record the response
    respVector(stimValues == theOrientation) = respVector(stimValues == theOrientation)...
        + response;

    % Add one to the counter for that stimulus
    countVector(stimValues == theOrientation) = countVector(stimValues == theOrientation) + 1;

end

data = [stimValues; respVector; countVector]';

figure;
plot(data(:, 1), data(:, 2) ./ data(:, 3), 'ro-', 'MarkerFaceColor', 'r');
axis([min(data(:, 1)) max(data(:, 1)) 0 1]);
xlabel('Location');
ylabel('Accuracy');
title('Psychometric function');

% Clean up
sca;