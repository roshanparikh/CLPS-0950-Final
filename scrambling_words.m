%scrambling words
scrambledWords = cell(1,25); %Creates a new cell to store the scrambled words
for i = 1:25
    inputScramble = char(wordsToScramble(1,i)); %uses list wordsToScramble as the input list
    outputScramble = randomizeStr(inputScramble);
    if outputScramble ~= inputScramble
        scrambledWords{1,i} = outputScramble;
    else 
        outputScramble = randomizeStr(inputScramble);
        scrambledWords{1,i} = outputScramble;
    end
end 