function n
  root = se9_2015_grading_root();
  [~, currentFolder] = fileparts(pwd);
  next = nextSubmission(currentFolder, root);
  if ~isempty(next)
    fprintf('%s\n', next);
    gotoSubmission(next, root);
  else
    fprintf('No next.\n');
  end
end
