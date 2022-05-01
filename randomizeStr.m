%Implicit Word 2- Scrambling words, Roshan's Workspace
function [outputStr]= randomizeStr(inputStr)
%WORD SCRAMBLER: This function scrambles the letters of a word. The word
%must be inputted as a vector of strings, where each letter is an element
%of the vector
    inputLength = length(inputStr);
    outputStr = [];
    outIndex = 1;
    while inputLength > 0
        wordIndex = randi(inputLength);
        outputStr(outIndex) = inputStr(wordIndex);
        inputStr(wordIndex) = [];
        inputLength = inputLength - 1;
        outIndex = outIndex + 1;
    end
    outputStr = char(outputStr);
end

