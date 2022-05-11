
edibleWords = cell(1,13);
edibleWords{1,1} = ['b' 'r' 'e' 'a' 'd'];
edibleWords{1,2} = ['w' 'a' 't' 'e' 'r'];
edibleWords{1,3} = ['a' 'v' 'o' 'c' 'a' 'd' 'o'];
edibleWords{1,4} = ['l' 'e' 'm' 'o' 'n' 'a' 'd' 'e'];
edibleWords{1,5} = ['a' 'u' 'b' 'e' 'r' 'g' 'i' 'n' 'e'];
edibleWords{1,6} = ['p' 'o' 'p' 's' 'i' 'c' 'l' 'e'];
edibleWords{1,7} = ['c' 'a' 'n' 'd' 'y'];
edibleWords{1,8} = ['j' 'e' 'l' 'l' 'y' ];
edibleWords{1,9} = ['p' 'a' 's' 't' 'a'];
edibleWords{1,10} = ['b' 'u' 'r' 'g' 'e' 'r'];
edibleWords{1,11} = ['s' 'o' 'u' 'p'];
edibleWords{1,12} = ['t' 'o' 'm' 'a' 't' 'o'];
edibleWords{1,13} = ['c' 'a' 'p' 's' 'i' 'c' 'u' 'm'];

for i = 1:randi(13,1)
    edible = char((edibleWords(1,i)));
end
disp(edible)