inedibleWords = cell(1,12);
inedibleWords{1,1} = ['b' 'o' 't' 't' 'l' 'e'];
inedibleWords{1,2} = ['j' 'a' 'c' 'k' 'e' 't'];
inedibleWords{1,3} = ['l' 'i' 'b' 'r' 'a' 'r' 'y'];
inedibleWords{1,4} = ['p' 'a' 'p' 'e' 'r'];
inedibleWords{1,5} = ['f' 'e' 'r' 'n' 's'];
inedibleWords{1,6} = ['h' 'e' 'a' 't'];
inedibleWords{1,7} = ['p' 'l' 'a' 'n' 'e' 't'];
inedibleWords{1,8} = ['p' 'a' 'i' 'n' 't'];
inedibleWords{1,9} = ['p' 'e' 'n'];
inedibleWords{1,10} = ['t' 'e' 'x' 't' 'b' 'o' 'o' 'k'];
inedibleWords{1,11} = ['c' 'o' 'm' 'p' 'u' 't' 'e' 'r'];
inedibleWords{1,12} = ['d' 'u' 'm' 'b' 'e' 'l' 'l'];

for i = 1:randi(12,1)
    inedible = char((inedibleWords(1,i)));
end
disp(inedible)


