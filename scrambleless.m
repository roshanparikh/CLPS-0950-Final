function [outputStr] = scrambleless(inputStr)
    outputStr = [inputStr];
    letter1 = randi(length(inputStr) - 2) + 1;
    letter2 = randi(length(inputStr) - 2) + 1;

    while outputStr == inputStr
        while letter1 == letter2
            letter2 = randi([2, length(inputStr)-1]);
        end   
    
        outL1 = outputStr(letter1);
        outL2 = outputStr(letter2);
    
        outputStr(letter1) = outL2;
        outputStr(letter2) = outL1;
    end
end
