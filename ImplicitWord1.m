
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

screens = Screen('Screens');

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

% k and l will be used to indicate the string of letters forming a word (k)
% or a nonword (l)
kKey = KbName('k');
escapeKey = KbName('ESCAPE');
lKey = KbName('l');

% intro screen that appears for the task (this is 2nd portion of the
% experiment)
DrawFormattedText(window, ['Congrats on completing the first portion of the task! \n\n ' ...
    'Press any key to continue!'],...
    'center', 'center', black);
Screen('Flip', window);
KbStrokeWait;

% instructions
Screen('TextSize', window, 25);
DrawFormattedText(window, ['In this task, you will be presented with a string of letters. \n\n ' ...
    'The letters will either make a word or a non-word. \n\n When the letters appear, press: \n\n the K key if the letters DO form a word, \n\n and press the L key if they do NOT form a word. \n\n ' ...
    '\n\n *Work as quickly as you can - if nothing is pressed in 1.5 seconds, the trial will be skipped! \n\n Press the L key to begin!'],...
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

% center the fixation dot on the screen
dotXpos = xCenter
dotYpos = yCenter
% Dot size in pixels
dotSizePix = 10;
scrambledWords = cell(1,25);

%set trialNum = 1, in order to give the trialType variable below a positive
%value
trialNum = 1
% reaction time trackers for each type of trial
tracker1 = 1; tracker2 = 1; tracker3 = 1; %tracks number of each trial type
rtTracker1 = [0]; rtTracker2 = [0]; rtTracker3 = [0];
%initializing an empty matrix to hold reaction times
rtTrackerTot = [0 0 0 0 0 0 0 0 0 0 0 0];
%randomly permuted matrix that ensures that trials are not repeated 
randomorder = randperm(12);
%15 trials, can move between them with a key press
Screen('TextSize', window, 40);
% 12 trials total: 4 new word, 4 primed word, 4 non-word
while trialNum < 12
    % checks for keypress
    [keyIsDown,secs, keyCode] = KbCheck;
    if keyCode(escapeKey)
        ShowCursor;
        sca;
        return

    else
        % increase trialNum, and set trialtype to a new value of the above
        % random matrix
            trialNum = trialNum + 1
            trialType = randomorder([trialNum])     
        % Flip to the screen
       Screen('Flip', window);
       % for first 4 trialTypes, run the scrambling word code
            if trialType == 1 || trialType == 2 || trialType == 3 || trialType == 4 %slider should only change r_given_exp
                run("scrambling_words.m")
                % bring fixation dot to the screen
                Screen('DrawDots', window, [xCenter yCenter], 10, black, [], 2);
                Screen('Flip', window);
                % random delay period between fixation pt and word
                % presentation
                WaitSecs(rand + rand + rand)
                % bring a randomly selected scrambled word from
                % "scrambling_words.m" to the screen
                 DrawFormattedText (window, (char((outputScramble))), ((rand + 0.5) * xCenter), ((rand+0.5)*yCenter), [1 0 0]);
                Screen('Flip', window);
                
            % for next 4 trialTypes, run the new word code
            elseif trialType == 5 || trialType == 6 || trialType == 7 || trialType == 8 
                run("new_words.m")
                % bring fixation dot to the screen
                Screen('DrawDots', window, [xCenter yCenter], 10, black, [], 2);
                Screen('Flip', window);
                % random delay period between fixation pt and word
                % presentation
                WaitSecs(rand + rand + rand);
                % bring a randomly selected word from
                % "new_words.m "to the screen
                DrawFormattedText (window, (char((inputNew))), ((rand + 0.5) * xCenter), ((rand+0.5)*yCenter), [1 0 0]);
                 Screen('Flip', window);
                
             % for next 4 trialTypes, run the primed word code 
            elseif trialType == 9 || trialType == 10 || trialType == 11 || trialType == 12
                run("combinedprimedwords.m")
                % bring fixation dot to the screen
                Screen('DrawDots', window, [xCenter yCenter], 10, black, [], 2);
                Screen('Flip', window);
                % random delay period between fixation pt and word
                % presentation
                WaitSecs(rand + rand + rand)
                % bring a randomly selected word from
                % "combinedprimedwords.m" to the screen
                DrawFormattedText (window, (char((allprimedWords))), ((rand + 0.5) * xCenter), ((rand+0.5)*yCenter), [1 0 0]);
                 Screen('Flip', window);
            end

% reset GetSecs at the beginning of each new traisl to obtain accurate rt
onsetTime = GetSecs;
rt =  1.5;
% when rt is over 1.5 seconds, move to next trial regardless of whether
% keypress has occurred or not
while (GetSecs - onsetTime) < 1.5
[keyIsDown,secs,keyCode] = PsychHID('KbCheck');
% if k or l key is pressed, wait until the key is released and then
% calculate reaction by subtracting the current time from the onset time
% at the beginning of each trial
    if keyCode(lKey)
        KbReleaseWait;
        rt = secs - onsetTime
     elseif keyCode(kKey)
         KbReleaseWait;
        rt = secs - onsetTime
     
        end
         end
 
% if the trial belonged to the first 4 trialTypes, add the reaction time to
% the first vector array, tracker1
    if trialType == 1|| trialType == 2 || trialType == 3 || trialType == 4
        rtTracker1(tracker1) = rt;
        tracker1 = tracker1 + 1;
% if the trial belonged to the next 4 trialTypes, add the reaction time to
% the second vector array, tracker2
    elseif trialType == 5 || trialType == 6 || trialType == 7 || trialType == 8 
        rtTracker2(tracker2) = rt;
        tracker2 = tracker2 + 1;
% if the trial belonged to the last 4 trialTypes, add the reaction time to
% the third vector array, tracker3
    elseif trialType == 9 || trialType == 10 || trialType == 11 || trialType == 12
        rtTracker3(tracker3) = rt;
        tracker3 = tracker3 + 1;
    end
   end

end

% calculate the mean reaction times for each trial condition, and the
% reaction time for all trials by taking the mean reaction time across all
% 3 conditions
rtWord = mean(rtTracker2);
rtPrimed = mean(rtTracker3);
rtNonword = mean(rtTracker1);
rtFinal = (rtWord+rtPrimed+rtNonword)/3;

% display debrief screen explaining the true goal of the task
Screen('TextSize', window, 18);
DrawFormattedText(window, ['Congrats on completing the tests! \n\n This was actually an implicit word test, \n\n which measured your ability to recall and respond to the words you viewed in the previous task (known as primed words),\n\n versus some new words you had not seen before, and some scrambled words. \n\n In theory, participants respond the fastest to primed words,\n\n and the slowest to scrambled words - but of course, everyone has a different experience.' '\n\n Press any key to see your reaction times. Thanks for playing!'],...
     'center', 'center', black);
 Screen('Flip', window);
 KbStrokeWait;

% displays reaction times, both in total and organized by trial condition
 Screen('TextSize', window, 30);
 DrawFormattedText(window, [strcat('Your average reaction time for all trials is:','  ', num2str(rtFinal), 's',  ' \n\n Your reaction time for previously seen (primed) words is:','   ', num2str(rtPrimed), 's', '\n\n Your reaction time for new words is:','   ', num2str(rtWord), 's', '\n\n Your reaction time for scrambled words is:','   ',num2str(rtNonword), 's', '\n\n Press any key to exit. Thanks for playing!')],...
     'center', 'center', black);
 Screen('Flip', window); 
 KbStrokeWait;

sca;
run('intro_screen.m')



