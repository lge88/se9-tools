function pv
  root = se9_2015_grading_root();
  [~, currentFolder] = fileparts(pwd);
  prev = prevSubmission(currentFolder, root);
  if ~isempty(prev)
    fprintf('%s\n', prev);
    gotoSubmission(prev, root);
  else
    fprintf('No prev.\n');
  end
end
