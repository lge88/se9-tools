function test_nextUID_

testOneCase('002');
testOneCase('176');
testOneCase('5');
testOneCase('05');
testOneCase('005');

end

function testOneCase(uid)
fprintf('nextUID_(%s,0) -> %s\n', uid, nextUID_(uid, 0));
fprintf('nextUID_(%s,1) -> %s\n', uid, nextUID_(uid, 1));
end