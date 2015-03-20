function g(uid)
  uid = sprintf('%03d', str2double(uid));
  root = se9_2015_grading_root();
  folder = searchSubmissionByUID(uid, root);
  if ~isempty(folder)
    fprintf('%s\n', folder);
    gotoSubmission(folder, root);
  else
    fprintf('%s is not found.\n', uid);
  end
end
