%Final project intro screen

%----------------------------------------------------------------------
%                       Setting up PTB
%----------------------------------------------------------------------

% Clear the workspace and the screen
sca;
close all;
clear all;
Screen('Preference', 'SkipSyncTests', 1);

% Here we call some default settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Get the screen numbers
screens = Screen('Screens');

% Draw to the external screen if avaliable
screenNumber = max(screens);

% Define black and white
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

%----------------------------------------------------------------------
%                       Creating the Window
%----------------------------------------------------------------------

% Open an on screen window
[window, windowRect] = PsychImaging('OpenWindow', 0, [255 255 255], [0 0 1000 1000], screenNumber, black, [], 32, 2);

% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

%----------------------------------------------------------------------
%                       Creating Rectangles
%----------------------------------------------------------------------

% Make a base Rect of 200 by 200 pixels
baseRect = [0 0 200 200];

% Screen X and Y positions of our three rectangles
squareXpos = [screenXpixels * 0.33 screenXpixels * 0.33 screenXpixels * 0.67 screenXpixels * 0.67];
squareYpos = [screenYpixels * 0.33 screenYpixels * 0.67 screenYpixels * 0.33 screenYpixels * 0.67];
numSqaures = length(squareXpos); 

corrector = baseRect(3)/4;

%----------------------------------------------------------------------
%                       Mouse Specifications
%----------------------------------------------------------------------
% Here we set the initial position of the mouse to be in the centre of the screen
SetMouse(screenXpixels * 0.33, screenYpixels * 0.66, window);

% We now set the squares initial position to the centre of the screen
sx = screenXpixels * 0.33;
sy = screenYpixels * 0.66;
%centeredRect = CenterRectOnPointd(baseRect2, xCenter, sy);
offsetSet = 0;

% Sync us and get a time stamp
vbl = Screen('Flip', window);
waitframes = 1;

% Maximum priority level
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);

%----------------------------------------------------------------------
%                       Intro Screen
%----------------------------------------------------------------------

DrawFormattedText(window, ['Welcome to the Brain Train Pain Game! \n\n ' ...
    'Press any key to choose your task (pick wisely...)!'],...
    'center', 'center', black);
Screen('Flip', window);
KbStrokeWait;

% Set the colors to Red, Green, Blue, and Yellow
allColors = [118 118 224 224; 210 224 162 118; 224 132 118 205]/255;

% Make our rectangle coordinates
% allRects = nan(4, 3);
% for i = 1:numSqaures
%     allRects(:, i) = CenterRectOnPointd(baseRect, squareXpos(i), squareYpos(i));
% end

rgbRect = CenterRectOnPointd(baseRect, squareXpos(1), squareYpos(1));
stroopRect = CenterRectOnPointd(baseRect, squareXpos(2), squareYpos(2));
wordRect = CenterRectOnPointd(baseRect, squareXpos(3), squareYpos(3));
memRect = CenterRectOnPointd(baseRect, squareXpos(4), squareYpos(4));

% Draw the rectangles to the screen
%Screen('FillRect', window, allColors, allRects);
Screen('FillRect', window, [118 210 224]/255, rgbRect);
Screen('FillRect', window, [118 224 132]/255, stroopRect);
Screen('FillRect', window, [224 162 118]/255, wordRect);
Screen('FillRect', window, [224 118 205]/255, memRect);

%RGB
DrawFormattedText(window, ['RGB \nAnomaloscope'], squareXpos(1) - corrector - 20, squareYpos(1) - corrector, white);

%Stroop
DrawFormattedText(window, ['Stroop Test'], squareXpos(2) - corrector, squareYpos(2) - corrector, white);

%Implicit Word Priming Task
DrawFormattedText(window, ['Linguistics'], squareXpos(3) - corrector, squareYpos(3) - corrector, white);

%Working Memory
DrawFormattedText(window, ['Working\nMemory'], squareXpos(4) - corrector, squareYpos(4)- corrector, white);

% Flip to the screen
Screen('Flip', window);
while KbCheck == 0
    % Get the current position of the mouse
    [mx, my, buttons] = GetMouse(window);

    % See if the mouse cursor is inside rgbRectthe square
    insideR = IsInRect(mx, my, rgbRect);
    insideS = IsInRect(mx,my, stroopRect);
    insideL = IsInRect(mx, my, wordRect);
    insideM = IsInRect(mx, my, memRect);

    if insideR == 1 && sum(buttons) == 1;
        i = 1
        RGB_v11;
    elseif insideS == 1 && sum(buttons) > 0
        i = 2
        strooplevel1;
        strooplevel2;
        strooplevel3;
        strooplevel4;
    elseif insideL == 1 && sum(buttons) > 0
        i = 3
        implicitpretest;


    
    elseif insideM == 1 && sum(buttons) > 0
        i = 4
        workingmemory1;
    end
end

% Wait for a key press
KbStrokeWait;

% Clear the screen
sca;


