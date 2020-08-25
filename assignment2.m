function varargout = assignment2(varargin)
% ASSIGNMENT2 MATLAB code for assignment2.fig
%      ASSIGNMENT2, by itself, creates a new ASSIGNMENT2 or raises the existing
%      singleton*.
%
%      H = ASSIGNMENT2 returns the handle to a new ASSIGNMENT2 or the handle to
%      the existing singleton*.
%
%      ASSIGNMENT2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ASSIGNMENT2.M with the given input arguments.
%
%      ASSIGNMENT2('Property','Value',...) creates a new ASSIGNMENT2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before assignment2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to assignment2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help assignment2

% Last Modified by GUIDE v2.5 01-Jul-2020 15:15:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @assignment2_OpeningFcn, ...
                   'gui_OutputFcn',  @assignment2_OutputFcn, ...
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


% --- Executes just before assignment2 is made visible.
function assignment2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to assignment2 (see VARARGIN)

% Choose default command line output for assignment2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes assignment2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function uipanel1_DeleteFcn(hObject, eventdata, handles)
delete(hObject);
clear functions;

% --- Outputs from this function are returned to the command line.
function varargout = assignment2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in playEdit.
function playEdit_Callback(hObject, eventdata, handles)
% hObject    handle to playEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global audioEdit;
play(audioEdit);

% --- Executes on button press in stopEdit.
function stopEdit_Callback(hObject, eventdata, handles)
% hObject    handle to stopEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global audioEdit;
stop(audioEdit);

% --- Executes on button press in cleanEdit.
function cleanEdit_Callback(hObject, eventdata, handles)
% hObject    handle to cleanEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global audioEdit yaudioEdit fsEdit;
if(isempty(audioEdit) == 0)
    audioEdit = 0;
    yaudioEdit = 0;
    fsEdit = 0;
    set(handles.cutStartA1, 'String', '');
    set(handles.cutEndA1, 'String', '');
    set(handles.cutStartA2, 'String', '');
    set(handles.cutEndA2, 'String', '');
    cla(handles.axeEdit,'reset');
end

% --- Executes on button press in pausEdit.
function pausEdit_Callback(hObject, eventdata, handles)
% hObject    handle to pausEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global audioEdit;
pause(audioEdit);

% --- Executes on button press in resumEdit.
function resumEdit_Callback(hObject, eventdata, handles)
% hObject    handle to resumEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global audioEdit;
resume(audioEdit);

% --- Executes on button press in btnCut.
function btnCut_Callback(hObject, eventdata, handles)
% hObject    handle to btnCut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global yAudio1  yAudio2 audioEdit yaudioEdit fsEdit fsAudio1 fsAudio2;

a1start = str2num(get(handles.cutStartA1, 'String'));
a1end = str2num(get(handles.cutEndA1, 'String'));

a2start = str2num(get(handles.cutStartA2, 'String'));
a2end = str2num(get(handles.cutEndA2, 'String'));

%a1 = yAudio1(a1start*fsAudio1:a1end*fsAudio1);
%a2 = yAudio2(a2start*fsAudio2:a2end*fsAudio2);
a1 = yAudio1((fsAudio1 * (a1start - 1)) + 1 : fsAudio1 * (a1end - 1), :);
a2 = yAudio2((fsAudio2 * (a2start - 1)) + 1 : fsAudio2 * (a2end - 1), :);

L1 = length(a1);
L2 = length(a2);

A1 = a1';
A2 = a2';

if fsAudio1 ~= fsAudio2
    errordlg('Different sample rates',' Warning ');
else
    if L2 > L1
        A1 = horzcat (A1 , zeros(1,length(a2) -length(a1)));
    else 
        A2 = horzcat (A2 , zeros(1, length(a1)-length(a2)));
    end
end

a3=(A1+A2)';
fsEdit = min(fsAudio1,fsAudio2);
L3 = length(a3);

if isempty(yaudioEdit) == 1 | yaudioEdit == 0
    yaudioEdit = [ yAudio1(1:(fsAudio1 * (a1start - 1)) + 1,:);a3(1:end,:); yAudio1(((fsAudio1 * (a1start - 1)) + 1)+L3:end,:)];
elseif isempty(yaudioEdit) == 0
    yaudioEdit = [ yaudioEdit(1:(fsAudio1 * (a1start - 1)) + 1,:);a3(1:end,:); yaudioEdit(((fsAudio1 * (a1start - 1)) + 1)+L3:end,:)];
end
    
dt = 1/fsEdit;
t = 0:dt:(length(yaudioEdit)*dt)-dt;
plot(handles.axeEdit,t,yaudioEdit);
legend(handles.axeEdit, sprintf('%d sample rate',fsEdit));
audioEdit = audioplayer(yaudioEdit, fsEdit);


% --- Executes on button press in btnSave.
function btnSave_Callback(hObject, eventdata, handles)
% hObject    handle to btnSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global yaudioEdit fsEdit;

[file, path] = uiputfile({'*.wav'}, 'Save edit as', 'editedAudio.wav');
if(file == 0)
    return;
else
    audioPath = fullfile(path, file);
    audiowrite(audioPath, yaudioEdit, fsEdit);
end

% --- Executes on button press in btnJoin.
function btnJoin_Callback(hObject, eventdata, handles)
% hObject    handle to btnJoin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global yAudio1 yAudio2 audioEdit fsAudio1 fsAudio2 yaudioEdit fsEdit;

if fsAudio1 ~= fsAudio2
    errordlg('Different sample rates',' Warning ');
else
    yaudioEdit = [yAudio1(:,1); yAudio2(:,1)];
    fsEdit = min(fsAudio1,fsAudio2);
    
    dt = 1/fsEdit;
    t = 0:dt:(length(yaudioEdit)*dt)-dt;
    plot(handles.axeEdit,t,yaudioEdit);
    legend(handles.axeEdit, sprintf('%d sample rate',fsEdit));
    audioEdit = audioplayer(yaudioEdit, fsEdit);
end

% --- Executes on button press in btnMerge.
function btnMerge_Callback(hObject, ~, handles)
% hObject    handle to btnMerge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global yAudio1 yAudio2 audioEdit fsAudio1 fsAudio2 yaudioEdit fsEdit;

A1 = yAudio1';
A2 = yAudio2';

L1 = length(yAudio1);
L2 = length(yAudio2);

if fsAudio1 ~= fsAudio2
    errordlg('Different sample rates',' Warning ');
else
    if L2 > L1
        A1 = horzcat (A1 , zeros(1,length(yAudio2) -length(yAudio1)));
    else
        A2 = horzcat (A2 , zeros(1, length(yAudio1)-length(yAudio2)));
    end
end

yaudioEdit = (A1+A2)';
fsEdit = min(fsAudio1,fsAudio2);

dt = 1/fsEdit;
t = 0:dt:(length(yaudioEdit)*dt)-dt;
plot(handles.axeEdit,t,yaudioEdit);
legend(handles.axeEdit, sprintf('%d sample rate',fsEdit));
audioEdit = audioplayer(yaudioEdit, fsEdit);


% --- Executes on button press in importA2.
function importA2_Callback(~, eventdata, handles)
% hObject    handle to importA2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global audio2 yAudio2 fsAudio2 audio2path;

[file, path] = uigetfile({'*.wav'}, 'Select an audio file'); %stores file name and path

if(file == 0)
    return;
else
%reads data from the audio file, and returns sampled data, y, and a sample rate for that data, Fs.
    [yAudio2, fsAudio2] = audioread([path,file]);
end

audio2 = audioplayer(yAudio2, fsAudio2);
audio2path = [path,file];

dt = 1/fsAudio2;
t = 0:dt:(length(yAudio2)*dt)-dt;
plot(handles.axeA2,t,yAudio2);
legend(handles.axeA2, sprintf('%d sample rate',fsAudio2))


% --- Executes on button press in playA2.
function playA2_Callback(hObject, eventdata, handles)
% hObject    handle to playA2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global audio2;
play(audio2);

% --- Executes on button press in stopA2.
function stopA2_Callback(hObject, eventdata, handles)
% hObject    handle to stopA2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global audio2;
stop(audio2);

% --- Executes on button press in removeA2.
function removeA2_Callback(hObject, eventdata, handles)
% hObject    handle to removeA2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global audio2 yAudio2 fsAudio2;

if(isempty(audio2) == 0)
    audio2 = 0;
    yAudio2 = 0;
    fsAudio2 = 0;
    cla(handles.axeA2,'reset');
    set(handles.volumeA2,'Value',1);
    set(handles.speedA2,'Value',1);
end

% --- Executes on button press in pauseA2.
function pauseA2_Callback(hObject, eventdata, handles)
% hObject    handle to pauseA2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global audio2;
pause(audio2);

% --- Executes on button press in resumeA2.
function resumeA2_Callback(hObject, eventdata, handles)
% hObject    handle to resumeA2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global audio2;
resume(audio2);

% --- Executes on slider movement.
function volumeA2_Callback(hObject, eventdata, handles)
% hObject    handle to volumeA2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global audio2 yAudio2 fsAudio2 audio2path;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
wasPlaying = isplaying(audio2);
pause(audio2);
newStart = get(audio2, 'CurrentSample');
[y,Fs] = audioread(audio2path);
Volume = get(handles.volumeA2, 'value');
yAudio2 = Volume*y;
fsAudio2 = Fs;
audio2 = audioplayer(yAudio2,fsAudio2);
dt = 1/fsAudio2;
t = 0:dt:(length(yAudio2)*dt)-dt;
plot(handles.axeA2,t,yAudio2);
legend(handles.axeA2, sprintf('%d sample rate',fsAudio2));

if(wasPlaying == 1)
    play(audio2,newStart);
end

% --- Executes during object creation, after setting all properties.
function volumeA2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to volumeA2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function speedA2_Callback(hObject, eventdata, handles)
% hObject    handle to speedA2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global audio2 yAudio2 fsAudio2 audio2path;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
wasPlaying = isplaying(audio2);
pause(audio2);
newStart = get(audio2, 'CurrentSample');
[y,Fs] = audioread(audio2path);
speed = get(handles.speedA2, 'value');
fsAudio2 = Fs*speed;
audio2 = audioplayer(yAudio2,fsAudio2);
dt = 1/fsAudio2;
t = 0:dt:(length(yAudio2)*dt)-dt;
plot(handles.axeA2,t,yAudio2);
legend(handles.axeA2, sprintf('%d sample rate',fsAudio2));

if(wasPlaying == 1)
    play(audio2,newStart);
end

% --- Executes during object creation, after setting all properties.
function speedA2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to speedA2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in recordA2.
function recordA2_Callback(hObject, eventdata, handles)
% hObject    handle to recordA2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global audio2;
audio2 = audiorecorder;
record(audio2);


% --- Executes on button press in importA1.
function importA1_Callback(hObject, eventdata, handles)
% hObject    handle to importA1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global audio1 yAudio1 fsAudio1 audio1path;

[file, path] = uigetfile({'*.wav'}, 'Select an audio file'); %stores file name and path

if(file == 0)
    return;
else
%reads data from the audio file, and returns sampled data, y, and a sample rate for that data, Fs.
    [yAudio1, fsAudio1] = audioread([path,file]);
end

audio1 = audioplayer(yAudio1, fsAudio1);
audio1path = [path,file];

dt = 1/fsAudio1;
t = 0:dt:(length(yAudio1)*dt)-dt;
plot(handles.axeA1,t,yAudio1)
legend(handles.axeA1, sprintf('%d sample rate',fsAudio1))

% --- Executes on button press in playA1.
function playA1_Callback(hObject, eventdata, handles)
% hObject    handle to playA1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global audio1;
play(audio1);

% --- Executes on button press in stopA1.
function stopA1_Callback(hObject, eventdata, handles)
% hObject    handle to stopA1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global audio1;
stop(audio1);

% --- Executes on button press in removeA1.
function removeA1_Callback(hObject, eventdata, handles)
% hObject    handle to removeA1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global audio1 yAudio1 fsAudio1;

if(isempty(audio1) == 0)
    audio1 = 0;
    yAudio1 = 0;
    fsAudio1 = 0;
    cla(handles.axeA1,'reset');
    set(handles.volumeA1,'Value',1);
    set(handles.speedA1,'Value',1);
end

% --- Executes on button press in pauseA1.
function pauseA1_Callback(hObject, eventdata, handles)
% hObject    handle to pauseA1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global audio1;
pause(audio1);

% --- Executes on button press in resumeA1.
function resumeA1_Callback(hObject, eventdata, handles)
% hObject    handle to resumeA1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global audio1;
resume(audio1);

% --- Executes on slider movement.
function volumeA1_Callback(hObject, eventdata, handles)
% hObject    handle to volumeA1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global audio1 yAudio1 fsAudio1 audio1path;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
wasPlaying = isplaying(audio1);
pause(audio1);
newStart = get(audio1, 'CurrentSample');
[y,Fs] = audioread(audio1path);
Volume = get(handles.volumeA1, 'value');
yAudio1 = Volume*y;
fsAudio1 = Fs;
audio1 = audioplayer(yAudio1,fsAudio1);
dt = 1/fsAudio1;
t = 0:dt:(length(yAudio1)*dt)-dt;
plot(handles.axeA1,t,yAudio1);
legend(handles.axeA1, sprintf('%d sample rate',fsAudio1));

if(wasPlaying == 1)
    play(audio1,newStart);
end

% --- Executes during object creation, after setting all properties.
function volumeA1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to volumeA1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function speedA1_Callback(hObject, eventdata, handles)
% hObject    handle to speedA1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global audio1 yAudio1 fsAudio1 audio1path;
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

wasPlaying = isplaying(audio1);
pause(audio1);
newStart = get(audio1, 'CurrentSample');
[y,Fs] = audioread(audio1path);
speed = get(handles.speedA1, 'value');
fsAudio1 = Fs*speed;
audio1 = audioplayer(yAudio1,fsAudio1);
dt = 1/fsAudio1;
t = 0:dt:(length(yAudio1)*dt)-dt;
plot(handles.axeA1,t,yAudio1);
legend(handles.axeA1, sprintf('%d sample rate',fsAudio1));

if(wasPlaying == 1)
    play(audio1,newStart);
end


% --- Executes during object creation, after setting all properties.
function speedA1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to speedA1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function cutStartA2_Callback(hObject, eventdata, handles)
% hObject    handle to cutStartA2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cutStartA2 as text
%        str2double(get(hObject,'String')) returns contents of cutStartA2 as a double


% --- Executes during object creation, after setting all properties.
function cutStartA2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cutStartA2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cutEndA2_Callback(hObject, eventdata, handles)
% hObject    handle to cutEndA2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cutEndA2 as text
%        str2double(get(hObject,'String')) returns contents of cutEndA2 as a double


% --- Executes during object creation, after setting all properties.
function cutEndA2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cutEndA2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cutStartA1_Callback(hObject, eventdata, handles)
% hObject    handle to cutStartA1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cutStartA1 as text
%        str2double(get(hObject,'String')) returns contents of cutStartA1 as a double


% --- Executes during object creation, after setting all properties.
function cutStartA1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cutStartA1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cutEndA1_Callback(hObject, eventdata, handles)
% hObject    handle to cutEndA1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cutEndA1 as text
%        str2double(get(hObject,'String')) returns contents of cutEndA1 as a double


% --- Executes during object creation, after setting all properties.
function cutEndA1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cutEndA1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in stopRec.
function stopRec_Callback(hObject, eventdata, handles)
% hObject    handle to stopRec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global audio2 yAudio2 fsAudio2 audio2path;
stop(audio2);
yAudio2 = getaudiodata(audio2);
audio2 = getplayer(audio2);
fsAudio2 = 8000;

dt = 1/fsAudio2;
t = 0:dt:(length(yAudio2)*dt)-dt;
plot(handles.axeA2,t,yAudio2);
legend(handles.axeA2, sprintf('%d sample rate',fsAudio2));

[file, path] = uiputfile({'*.wav'}, 'Save recording', 'recording.wav');
if(file == 0)
    return;
else
    audio2path = fullfile(path, file);
    audiowrite(audio2path, yAudio2, fsAudio2);
end


function a2SampleR_Callback(hObject, eventdata, handles)
% hObject    handle to a2SampleR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a2SampleR as text
%        str2double(get(hObject,'String')) returns contents of a2SampleR as a double


% --- Executes during object creation, after setting all properties.
function a2SampleR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a2SampleR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in a2Resample.
function a2Resample_Callback(hObject, eventdata, handles)
% hObject    handle to a2Resample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global audio2 yAudio2 fsAudio2;
fr2 = get(handles.a2SampleR,'String');
fr2 = str2num(fr2);

yAudio2 = resample(yAudio2,fr2,fsAudio2);
fsAudio2 = fr2;

audio2 = audioplayer(yAudio2,fsAudio2);
dt = 1/fsAudio2;
t = 0:dt:(length(yAudio2)*dt)-dt;
plot(handles.axeA2,t,yAudio2);
legend(handles.axeA2, sprintf('%d sample rate',fr2));
set(handles.a2SampleR, 'String', '');


% --- Executes on button press in a1Resample.
function a1Resample_Callback(hObject, eventdata, handles)
% hObject    handle to a1Resample (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global audio1 yAudio1 fsAudio1;
fr1 = get(handles.a1SampleR,'String');
fr1 = str2num(fr1);

yAudio1 = resample(yAudio1,fr1,fsAudio1);
fsAudio1 = fr1;

audio1 = audioplayer(yAudio1,fsAudio1);
dt = 1/fsAudio1;
t = 0:dt:(length(yAudio1)*dt)-dt;
plot(handles.axeA1,t,yAudio1);
legend(handles.axeA1, sprintf('%d sample rate',fr1));
set(handles.a1SampleR, 'String', '');


function a1SampleR_Callback(hObject, eventdata, handles)
% hObject    handle to a1SampleR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a1SampleR as text
%        str2double(get(hObject,'String')) returns contents of a1SampleR as a double


% --- Executes during object creation, after setting all properties.
function a1SampleR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a1SampleR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ediTime_Callback(hObject, eventdata, handles)
% hObject    handle to ediTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ediTime as text
%        str2double(get(hObject,'String')) returns contents of ediTime as a double


% --- Executes during object creation, after setting all properties.
function ediTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ediTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a2Time_Callback(hObject, eventdata, handles)
% hObject    handle to a2Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a2Time as text
%        str2double(get(hObject,'String')) returns contents of a2Time as a double


% --- Executes during object creation, after setting all properties.
function a2Time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a2Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a1Time_Callback(hObject, eventdata, handles)
% hObject    handle to a1Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a1Time as text
%        str2double(get(hObject,'String')) returns contents of a1Time as a double


% --- Executes during object creation, after setting all properties.
function a1Time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a1Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
