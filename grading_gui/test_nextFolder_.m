function test_nextFolder_
root = se9_2015_grading_root();

testOneCase('final_002_acton');
testOneCase('final_003_anaya');
testOneCase('final_005_arambulo');
testOneCase('final_176_fok');

    function testOneCase(folder)
        fprintf('nextFolder_(%s,0) -> %s\n', folder, ...
            nextFolder_(folder, root, 0));
        fprintf('nextFolder_(%s,1) -> %s\n', folder, ...
            nextFolder_(folder, root, 1));
    end

end

