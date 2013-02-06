function varargout = spindleGUI(varargin)
showDisks = 0;
showCylinders = 0;
showSpheres = 0;
diskFC = 'all';
cylinderFC = 'all';
sphereFC = 'all';
kmtRadius = 125;
kmtUncertaintySphereRadius = 0;
% GUI M-file for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 06-Feb-2013 16:19:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @spindleGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @spindleGUI_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function spindleGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = spindleGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
showDisks = get(hObject,'Value')
% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
showCylinders = get(hObject,'Value')
% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
showSpheres = get(hObject,'Value')
% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in generateSimulationButton.
function generateSimulationButton_Callback(hObject, eventdata, handles)

showDisks = get(handles.checkbox1,'Value')
if showDisks == 1
	showDisks = 'true'
	else
	showDisks = 'false'
end
showCylinders = get(handles.checkbox2,'Value')
if showCylinders == 1
	showCylinders = 'true'
	else
	showCylinders = 'false'
end
showSpheres = get(handles.checkbox3,'Value')
if showSpheres == 1
	showSpheres = 'true'
	else
	showSpheres = 'false'
end
%fprintf('showSpheres = %s',showSpheres)
diskFC = get(handles.popupmenu1,'Value')
cylinderFC = get(handles.popupmenu2,'Value')
sphereFC = get(handles.popupmenu3,'Value')
fcvec = [diskFC cylinderFC sphereFC]
stringvec = {'none','none','none'}
colorvec = {'red','green','blue','all'}
for i = 1:3
	if fcvec(i) == 1
		stringvec{i} = colorvec{1}
	end
	if fcvec(i) == 2
		stringvec{i} = colorvec{2}
	end
	if fcvec(i) == 3
		stringvec{i} = colorvec{3}
	end
	if fcvec(i) == 4
		stringvec{i} = colorvec{4}
	end
end
kmtRadius1 = str2double(get(handles.kmtRadiusEdit1,'String'));
kmtUncertaintySphereRadius1 = str2double(get(handles.kmtUncertaintySphereRadiusEdit1,'String'));
kmtRadius2 = str2double(get(handles.kmtRadiusEdit2,'String'));
kmtUncertaintySphereRadius2 = str2double(get(handles.kmtUncertaintySphereRadiusEdit2,'String'));
kmtRadius3 = str2double(get(handles.kmtRadiusEdit3,'String'));
kmtUncertaintySphereRadius3 = str2double(get(handles.kmtUncertaintySphereRadiusEdit3,'String'));


spindleSimDriver(showDisks,showCylinders,showSpheres,...
    stringvec{1},stringvec{2},stringvec{3},...
    kmtRadius1,kmtUncertaintySphereRadius1,...
    kmtRadius2,kmtUncertaintySphereRadius2,...
    kmtRadius3,kmtUncertaintySphereRadius3);
guidata(hObject,handles)
% hObject    handle to generateSimulationButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(hObject,'String'))
diskFC = contents{get(hObject,'Value')}
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(hObject,'String'))
cylinderFC = contents{get(hObject,'Value')}
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(hObject,'String'))
sphereFC = contents{get(hObject,'Value')}
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kmtRadiusEdit1_Callback(hObject, eventdata, handles)
% hObject    handle to kmtRadiusEdit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kmtRadiusEdit1 as text
%        str2double(get(hObject,'String')) returns contents of kmtRadiusEdit1 as a double
kmtRadius = str2double(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function kmtRadiusEdit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kmtRadiusEdit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kmtUncertaintySphereRadiusEdit1_Callback(hObject, eventdata, handles)
% hObject    handle to kmtUncertaintySphereRadiusEdit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kmtUncertaintySphereRadiusEdit1 as text
%        str2double(get(hObject,'String')) returns contents of kmtUncertaintySphereRadiusEdit1 as a double


% --- Executes during object creation, after setting all properties.
function kmtUncertaintySphereRadiusEdit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kmtUncertaintySphereRadiusEdit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kmtRadiusEdit2_Callback(hObject, eventdata, handles)
% hObject    handle to kmtRadiusEdit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kmtRadiusEdit2 as text
%        str2double(get(hObject,'String')) returns contents of kmtRadiusEdit2 as a double


% --- Executes during object creation, after setting all properties.
function kmtRadiusEdit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kmtRadiusEdit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kmtRadiusEdit3_Callback(hObject, eventdata, handles)
% hObject    handle to kmtRadiusEdit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kmtRadiusEdit3 as text
%        str2double(get(hObject,'String')) returns contents of kmtRadiusEdit3 as a double


% --- Executes during object creation, after setting all properties.
function kmtRadiusEdit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kmtRadiusEdit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kmtUncertaintySphereRadiusEdit2_Callback(hObject, eventdata, handles)
% hObject    handle to kmtUncertaintySphereRadiusEdit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kmtUncertaintySphereRadiusEdit2 as text
%        str2double(get(hObject,'String')) returns contents of kmtUncertaintySphereRadiusEdit2 as a double


% --- Executes during object creation, after setting all properties.
function kmtUncertaintySphereRadiusEdit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kmtUncertaintySphereRadiusEdit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kmtUncertaintySphereRadiusEdit3_Callback(hObject, eventdata, handles)
% hObject    handle to kmtUncertaintySphereRadiusEdit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kmtUncertaintySphereRadiusEdit3 as text
%        str2double(get(hObject,'String')) returns contents of kmtUncertaintySphereRadiusEdit3 as a double


% --- Executes during object creation, after setting all properties.
function kmtUncertaintySphereRadiusEdit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kmtUncertaintySphereRadiusEdit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
