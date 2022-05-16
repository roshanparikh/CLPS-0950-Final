% Clear the workspace and the screen
sca;
close all;
clear all;
Screen('Preference', 'SkipSyncTests', 1);

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Seed the random number generator. Here we use the an older way to be
% compatible with older systems. Newer syntax would be rng('shuffle').
% For help see: help rand
rand('seed', sum(100 * clock));

% Get the screen numbers. This gives us a number for each of the screens
% attached to our computer. For help see: Screen Screens?
screens = Screen('Screens');

% Draw we select the maximum of these numbers. So in a situation where we
% have two screens attached to our monitor we will draw to the external
% screen. When only one screen is attached to the monitor we will draw to
% this. For help see: help max
screenNumber = max(screens);

% Define black and white (white will be 1 and black 0). This is because
% luminace values are (in general) defined between 0 and 1.
% For help see: help WhiteIndex and help BlackIndex
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

% Open the screen, defined as 1000 x 1000 matrix
[window, windowRect] = PsychImaging('OpenWindow', 0, [255 255 255], [0 0 1000 1000], screenNumber, white, [], 32, 2);
%Here screen is opened just for changing the SyncTest preference

[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Flip to clear
Screen('Flip', window);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

% Set text size to 40 
Screen('TextSize', window, 25);

% Query the maximum priority level
topPriorityLevel = MaxPriority(window);

% Get the centre coordinate of the window in pixels
% For help see: help RectCenter
[xCenter, yCenter] = RectCenter(windowRect);

% Enable alpha blending for anti-aliasing
% For help see: Screen BlendFunction?
% Also see: Chapter 6 of the OpenGL programming guide
Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);


%----------------------------------------------------------------------
%                       Keyboard Presses
%----------------------------------------------------------------------
% k and l will be used to indicate the word respresenting an edible (k) or
% inedible (l) object
kKey = KbName('k');
escapeKey = KbName('ESCAPE');
lKey = KbName('l');

% intro display screen
DrawFormattedText(window, ['Welcome to the Cognitive Linguistics Test! \n\n ' ...
    'Press any key to see instructions!'],...
    'center', 'center', black);
Screen('Flip', window);
KbStrokeWait;

% instructions screen
DrawFormattedText(window, ['In this task, you will be presented with 25 words.  \n\n ' ...
    'The word will either represent an edible object, or an inedible one. \n\n When the word appears, press: \n\n the K key if the item is edible,\n\n and the L key if it is inedible. \n\n ' ...
    'Press the L key TWICE to begin!'],...
    'center', 'center', black);
Screen('Flip', window);
KbStrokeWait;

%----------------------------------------------------------------------
%                       Timing Information
%----------------------------------------------------------------------

% Stimulus interval time in seconds and frames
isiTimeSecs = 1;
isiTimeFrames = round(isiTimeSecs / ifi);


% Number of frames to wait before next stimulus
waitframes = 1;


% Set the color of our fixation dot to black
dotColor = [0 0 0];

% set position of fixation dot to center of the screen
dotXpos = xCenter
dotYpos = yCenter
% Dot size in pixels
dotSizePix = 10;


trialNum = 1;
% randomly permuted matrix, ensures that a new word from the list is
% presented each trial (no repeats)
randompretest = randperm(25)
Screen('TextSize', window, 40);

% run pre-survey word list
run("combinedprimedwords.m")
%2 5 trials, can move between them with a key press
while trialNum < 25
    % check for key press
    [keyIsDown,secs, keyCode] = KbCheck;
    if keyCode(escapeKey)
        ShowCursor;
        sca;
        return
    % when key pressed, move to the new screen (display the next word)
    elseif keyCode(kKey) || keyCode(lKey)
             
        % Flip to the screen
        Screen('Flip', window);

% presentation loop for all 25 trials        
for trialNum = 1:25
     Screen('DrawDots', window, [xCenter yCenter], 10, black, [], 2);
                Screen('Flip', window);
                % random delay period between fixation pt and word
                % presentation
                WaitSecs(rand + rand + rand);
                % bring a random word from the list to the screen
                DrawFormattedText (window, (char((combinedprimeshuffled(trialNum)))), ((rand + 0.5) * xCenter), ((rand+0.5)*yCenter), [1 0 0]);
                 Screen('Flip', window);
                 KbStrokeWait;
                 %Move to the next trial
                 trialNum = trialNum + 1
end
       



        end
end
% after 25 trials, display the screen that directs participant to the
% second part of the task
if trialNum == 26
 WaitSecs(0.2);
 Screen('TextSize', window, 20);
 DrawFormattedText(window, [strcat('Great job! We will now continue to the second portion of the task \n\n Press any key to continue.')],...
     'center', 'center', black);
Screen('Flip', window);
end
KbStrokeWait
sca;
% run the second (survey) portion of the task
run ImplicitWord1.m



