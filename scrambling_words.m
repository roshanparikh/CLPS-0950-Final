%scrambling words
scrambledWords = cell(1,25);
for i = 1:25
    inputScramble = char(wordsToScramble(1,i));
    outputScramble = randomizeStr(inputScramble);
    if outputScramble ~= inputScramble
        scrambledWords{1,i} = outputScramble;
    else 
        outputScramble = randomizeStr(inputScramble);
        scrambledWords{1,i} = outputScramble;
    end
end 