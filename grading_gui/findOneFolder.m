function folder = findOneFolder(folderPattern)
  isOctave = exist('OCTAVE_VERSION', 'builtin') ~= 0;
  if isOctave
    mayBeFolder = glob(folderPattern);
    if isempty(mayBeFolder)
      folder = '';
    else
      folder = mayBeFolder{1};
      %% ugly
      folder = folder(85:end);
    end
  else
    mayBeFolder = dir(folderPattern);
    if isempty(mayBeFolder)
      folder = '';
    else
      folder = mayBeFolder(1).name;
    end
  end

end
