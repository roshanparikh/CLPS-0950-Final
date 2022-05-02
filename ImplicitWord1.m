% Edited by Imaad Said, 4/29/2022 at 1:30

% Clear the workspace and the screen
sca;
close all;
clear;

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
Screen('TextSize', window, 40);

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

rightKey = KbName('RightArrow');
escapeKey = KbName('ESCAPE');
leftKey = KbName('LeftArrow');

%----------------------------------------------------------------------
%                       Timing Information
%----------------------------------------------------------------------

% Stimulus interval time in seconds and frames
isiTimeSecs = 1;
isiTimeFrames = round(isiTimeSecs / ifi);


% Number of frames to wait before next stimulus
waitframes = 100;


% Set the color of our dot to full red. Color is defined by red green
% and blue components (RGB). So we have three numbers which
% define our RGB values. The maximum number for each is 1 and the minimum
% 0. So, "full red" is [1 0 0]. "Full green" [0 1 0] and "full blue" [0 0
% 1]. Play around with these numbers and see the result.
dotColor = [0 0 0];

% Determine a random X and Y position for our dot. NOTE: As dot position is
% randomised each time you run the reenript the output picture will show the
% dot in a different position. Similarly, when you run the script the
% position of the dot will be randomised each time. NOTE also, that if the
% dot is drawn at the edge of the screen some of it might not be visible.
dotXpos = xCenter
dotYpos = yCenter
% Dot size in pixels
dotSizePix = 10;
scrambledWords = cell(1,25);

% Make the matrix which will determine our condition combinations
condMatrixBase = [sort(repmat([1 2 3 4], 1, 3)); repmat([1 2 3 4], 1, 3)];% This matrix is 12 columns wide, allowing us to record the results of each trial


% This is for the number of trials per condition, giving us a total of 12 trials.
trialsPerCondition = 1;

% Duplicate the condition matrix to get the full number of trials
condMatrix = repmat(condMatrixBase, 1, trialsPerCondition);

% Get the size of the matrix
[~, numTrials] = size(condMatrix);

% To randomize the conditions so that a randomly chosen word is presented in a
% randomly chosen color
shuffler = Shuffle(1:numTrials);
condMatrixShuffled = condMatrix(:, shuffler);
% Draw the dot to the screen. For information on the command used in
% this line type "Screen DrawDots?" at the command line (without the
% brackets) and press enter. Here we used good antialiasing to get nice
% smooth edges
numTrials = 5
wordsToScramble = cell(1, 25);
wordsToScramble{1,1} = ['k' 'n' 'i' 'f' 'e'];
wordsToScramble{1,2} = ['a' 'r' 't' 'i' 's' 't'];
wordsToScramble{1,3} = ['p' 'a' 'i' 'n' 't' 'e' 'r'];
wordsToScramble{1,4} = ['c' 'h' 'e' 'f'];
wordsToScramble{1,5} = ['v' 'e' 'r' 'd' 'a' 'n' 't'];
wordsToScramble{1,6} = ['c' 'r' 'e' 'a' 't' 'i' 'o' 'n'];
wordsToScramble{1,7} = ['b' 'u' 'i' 'l' 'd' 'i' 'n' 'g'];
wordsToScramble{1,8} = ['t' 'e' 'a'];
wordsToScramble{1,9} = ['b' 'u' 'b' 'b' 'l' 'e' 's'];
wordsToScramble{1,10} = ['c' 'o' 'f' 'f' 'e' 'e'];
wordsToScramble{1,11} = ['s' 'u' 's' 'h' 'i'];
wordsToScramble{1,12} = ['b' 'o' 'o' 'k' 's' 't' 'o' 'r' 'e'];
wordsToScramble{1,13} = ['o' 'f' 'f' 'i' 'c' 'e'];
wordsToScramble{1,14} = ['f' 'l' 'a' 'g'];
wordsToScramble{1,15} = ['n' 'a' 't' 'i' 'o' 'n'];
wordsToScramble{1,16} = ['l' 'a' 'k' 'e'];
wordsToScramble{1,17} = ['p' 'o' 'n' 'd'];
wordsToScramble{1,18} = ['f' 'a' 'm' 'i' 'l' 'y'];
wordsToScramble{1,19} = ['m' 'o' 't' 'h' 'e' 'r'];
wordsToScramble{1,20} = ['o' 'k' 'r' 'a'];
wordsToScramble{1,21} = ['b' 'a' 'n' 'k'];
wordsToScramble{1,22} = ['k' 'a' 'b' 'o' 'b'];
wordsToScramble{1,23} = ['y' 'e' 'l' 'l' 'o' 'w'];
wordsToScramble{1,24} = ['v' 'e' 'g' 'a' 'n'];
wordsToScramble{1,25} = ['c' 'l' 'e' 'm' 'e' 'n' 't' 'i' 'n' 'e'];
vbl = Screen('Flip', window);

for trial = 1:numTrials
for i = 1:25
    inputScramble = char(wordsToScramble(1,i));
    outputScramble = randomizeStr(inputScramble);
    scrambledWords{1,i} = outputScramble;

Screen('DrawDots', window, [dotXpos dotYpos], dotSizePix, dotColor, [], 2);

% Flip to the screen. This command basically draws all of our previous
% commands onto the screen. See later demos in the animation section on more
% timing details. And how to demos in this section on how to draw multiple
% rects at once.
% For help see: Screen Flip?
  vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);

% Now we have drawn to the screen we wait for a keyboard button press (any
% key) to terminate the demo. For help see: help KbStrokeWait

Screen('TextSize', window, 50);
DrawFormattedText (window, char((outputScramble)), (screenXpixels * 0.15), 'center', [1 0 0]);

% Flip to the screen
  vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
KbStrokeWait;
end
end
% Now we have drawn to the screen we wait for a keyboard button press (any
% key) to terminate the demo


% Clear the screen. "sca" is short hand for "Screen CloseAll". This clears
% all features related to PTB. Note: we leave the variables in the
% workspace so you can have a look at them if you want.
% For help see: help sca
sca;


