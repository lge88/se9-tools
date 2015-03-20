function folder = searchSubmissionByUID(uid, root)
  pattern = fullfile(root, ['final_', uid, '_*']);
folder = findOneFolder(pattern);
end
