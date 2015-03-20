function folder = nextFolder_(currentFolder, root, reversed)
uid = parseUIDFromFolder(currentFolder);

uid = nextUID_(uid, reversed);
folderPattern = fullfile(root, ['final_', uid, '_*']);
folder = findOneFolder(folderPattern);

while isempty(folder)
    uid = nextUID_(uid, reversed);
    folderPattern = fullfile(root, ['final_', uid, '_*']);
    folder = findOneFolder(folderPattern);
end

end
