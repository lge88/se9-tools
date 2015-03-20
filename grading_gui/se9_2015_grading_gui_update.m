function se9_2015_grading_gui_update(handles)

appState = handles.appState;
root = appState.root;
uid = appState.currentUID;
currentSubmission = searchSubmissionByUID(uid, root);

if ~isempty(currentSubmission)
    set(handles.root, 'String', root);
    set(handles.uid, 'String', uid);
    set(handles.cwd, 'String', currentSubmission);
    gotoSubmission(currentSubmission, root)
end


end