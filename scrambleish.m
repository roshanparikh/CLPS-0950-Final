function [outputStr] = scrambleish(inputStr)
% function to scramble words while keeping the first and last letter the
%same
    outputStr = [inputStr(1)]; %keeps the first letter the same
    inputStr(1) = []; %removes first letter from the initial word
    lastLetter = inputStr(end); %stores last letter of word
    inputStr(end) = [];
    inputLength = length(inputStr);
    outIndex = 2;
    while inputLength > 0
        wordIndex = randi(inputLength);
        outputStr(outIndex) = inputStr(wordIndex);
        inputStr(wordIndex) = [];
        inputLength = inputLength - 1;
        outIndex = outIndex + 1;
    end
    outputStr(end + 1) = lastLetter;
    outputStr = char(outputStr);
end