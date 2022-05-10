scrambledWords_less = cell(1,25); %Creates a new cell to store the scrambled words; make the second number equal to the length of the word scrambling list
for i = 1:25 %make the second number the length of the word list
    inputScramble3 = char(wordsToScramble(1,i)); %uses list wordsToScramble as the input list
    outputScramble3 = scrambleless(inputScramble3); 
    scrambledWords_less{1,i} = outputScramble3;
end 