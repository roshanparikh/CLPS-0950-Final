%Implicit Word 2- Scrambling words, Roshan's Workspace
function [outputStr]= randomizeStr(inputStr)
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

