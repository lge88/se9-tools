function varargout = se9_2015_grading_gui(varargin)
% SE9_2015_GRADING_GUI MATLAB code for se9_2015_grading_gui.fig
%      SE9_2015_GRADING_GUI, by itself, creates a new SE9_2015_GRADING_GUI or raises the existing
%      singleton*.
%
%      H = SE9_2015_GRADING_GUI returns the handle to a new SE9_2015_GRADING_GUI or the handle to
%      the existing singleton*.
%
%      SE9_2015_GRADING_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SE9_2015_GRADING_GUI.M with the given input arguments.
%
%      SE9_2015_GRADING_GUI('Property','Value',...) creates a new SE9_2015_GRADING_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before se9_2015_grading_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to se9_2015_grading_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help se9_2015_grading_gui

% Last Modified by GUIDE v2.5 19-Mar-2015 17:47:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @se9_2015_grading_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @se9_2015_grading_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before se9_2015_grading_gui is made visible.
function se9_2015_grading_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to se9_2015_grading_gui (see VARARGIN)

% Choose default command line output for se9_2015_grading_gui
handles.output = hObject;

absPathOfThisScript = which('se9_2015_grading_gui');
% ../../submissions/final_cleaned
docFolder = fileparts(fileparts(absPathOfThisScript));
appState.root = fullfile(docFolder, 'submissions', 'final_cleaned');
appState.currentUID = '002';
handles.appState = appState;

% Update handles structure
guidata(hObject, handles);
se9_2015_grading_gui_update(handles);

% UIWAIT makes se9_2015_grading_gui wait for user response (see UIRESUME)
% uiwait(handles.appFigure);


% --- Outputs from this function are returned to the command line.
function varargout = se9_2015_grading_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in setroot.
function setroot_Callback(hObject, eventdata, handles)
% hObject    handle to setroot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
root = uigetdir();
handles.appState.root = root;
guidata(hObject, handles);
se9_2015_grading_gui_update(handles);


% --- Executes on button press in prev.
function prev_Callback(hObject, eventdata, handles)
% hObject    handle to prev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

uid = handles.appState.currentUID;
root = handles.appState.root;
submission = searchSubmissionByUID(uid, root);
if ~isempty(submission)
    submission = prevSubmission(submission, root);
    handles.appState.currentUID = parseUIDFromFolder(submission);
    guidata(hObject, handles);
    se9_2015_grading_gui_update(handles);
end


% --- Executes on button press in next.
function next_Callback(hObject, eventdata, handles)
% hObject    handle to next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uid = handles.appState.currentUID;
root = handles.appState.root;
submission = searchSubmissionByUID(uid, root);
if ~isempty(submission)
    submission = nextSubmission(submission, root);
    handles.appState.currentUID = parseUIDFromFolder(submission);
    guidata(hObject, handles);
    se9_2015_grading_gui_update(handles);
end


function uid_Callback(hObject, eventdata, handles)
% hObject    handle to uid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of uid as text
%        str2double(get(hObject,'String')) returns contents of uid as a double


% --- Executes during object creation, after setting all properties.
function uid_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in go.
function go_Callback(hObject, eventdata, handles)
% hObject    handle to go (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
appState = handles.appState;
inputUID = get(handles.uid, 'String');
inputUID = sprintf('%03d', str2double(inputUID));
submission = searchSubmissionByUID(inputUID, appState.root);
if ~isempty(submission)
    handles.appState.currentUID = inputUID;
    guidata(hObject, handles);
    se9_2015_grading_gui_update(handles);
else
    set(handles.uid, 'String', appState.currentUID);
end


% --- Executes on button press in clc.
function clc_Callback(hObject, eventdata, handles)
% hObject    handle to clc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc


% --- Executes on button press in clear.
function clear_Callback(hObject, eventdata, handles)
% hObject    handle to clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear

% --- Executes on button press in clearAll.
function clearAll_Callback(hObject, eventdata, handles)
% hObject    handle to clearAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function appFigure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to appFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes on button press in refresh.
function refresh_Callback(hObject, eventdata, handles)
% hObject    handle to refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear;clc;close all;

% --- Executes on button press in closeall.
function closeall_Callback(hObject, eventdata, handles)
% hObject    handle to closeall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;



function cmd1_Callback(hObject, eventdata, handles)
% hObject    handle to cmd1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cmd1 as text
%        str2double(get(hObject,'String')) returns contents of cmd1 as a double


% --- Executes during object creation, after setting all properties.
function cmd1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmd1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in run1.
function run1_Callback(hObject, eventdata, handles)
% hObject    handle to run1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
eval(get(handles.cmd1, 'String'));



function cmd2_Callback(hObject, eventdata, handles)
% hObject    handle to cmd2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cmd2 as text
%        str2double(get(hObject,'String')) returns contents of cmd2 as a double


% --- Executes during object creation, after setting all properties.
function cmd2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmd2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in run2.
function run2_Callback(hObject, eventdata, handles)
% hObject    handle to run2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
eval(get(handles.cmd2, 'String'));



function cmd3_Callback(hObject, eventdata, handles)
% hObject    handle to cmd3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cmd3 as text
%        str2double(get(hObject,'String')) returns contents of cmd3 as a double


% --- Executes during object creation, after setting all properties.
function cmd3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmd3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in run3.
function run3_Callback(hObject, eventdata, handles)
% hObject    handle to run3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
eval(get(handles.cmd3, 'String'));



function cmd4_Callback(hObject, eventdata, handles)
% hObject    handle to cmd4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cmd4 as text
%        str2double(get(hObject,'String')) returns contents of cmd4 as a double


% --- Executes during object creation, after setting all properties.
function cmd4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmd4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in run4.
function run4_Callback(hObject, eventdata, handles)
% hObject    handle to run4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
eval(get(handles.cmd4, 'String'));



function cmd5_Callback(hObject, eventdata, handles)
% hObject    handle to cmd5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cmd5 as text
%        str2double(get(hObject,'String')) returns contents of cmd5 as a double


% --- Executes during object creation, after setting all properties.
function cmd5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmd5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in run5.
function run5_Callback(hObject, eventdata, handles)
% hObject    handle to run5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
eval(get(handles.cmd5, 'String'));



function cmd6_Callback(hObject, eventdata, handles)
% hObject    handle to cmd6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cmd6 as text
%        str2double(get(hObject,'String')) returns contents of cmd6 as a double


% --- Executes during object creation, after setting all properties.
function cmd6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cmd6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in run6.
function run6_Callback(hObject, eventdata, handles)
% hObject    handle to run6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
eval(get(handles.cmd6, 'String'));
