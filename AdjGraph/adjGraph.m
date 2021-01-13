function varargout = adjGraph(varargin)
% ADJGRAPH MATLAB code for adjGraph.fig

%{
  This file is part of MonteCarloRedistributionAlgorithm (MCRA)
  Copyright (C) 2020  N. Suhas Jagannathan
  MCRA is free software: you can redistribute it and/or modify it 
  under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.
  MCRA is distributed in the hope that it will be useful,but WITHOUT 
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY 
  or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License 
  for more details.You should have received a copy of the GNU General 
  Public License along with MCRA.  If not, see <https://www.gnu.org/licenses/>.
%} 

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @adjGraph_OpeningFcn, ...
    'gui_OutputFcn',  @adjGraph_OutputFcn, ...
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


% --- Executes just before adjGraph is made visible.
function adjGraph_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to adjGraph (see VARARGIN)

% Choose default command line output for adjGraph
handles.output = hObject;
set(handles.hideLinesCheckBox,'enable','on');
set(handles.hideLinesCheckBox,'enable','inactive');
set(gca,'XTick',[],'YTick',[]);
cla;
set(handles.log,'string',{['Event log']});
% Update handles structure
guidata(hObject, handles);



% UIWAIT makes adjGraph wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = adjGraph_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in removeButton.
function removeButton_Callback(hObject, eventdata, handles)
% hObject    handle to removeButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    handles.temp.data;
catch
    disp('Please check if the required data csv file is loaded');
    return;
end

fib1 = str2double(get(handles.edit1,'String'));
fib2 = str2double(get(handles.edit2,'String'));
try
    imshow(handles.temp.data.image);
    adj1 = cell2mat(handles.temp.data.adj{fib1});
    adj2 = cell2mat(handles.temp.data.adj{fib2});
    adj1_2_index = find(adj1==fib2);
    if adj1_2_index > 0
        adj1(adj1_2_index) = [];
        handles.temp.data.adj{fib1} = num2cell(adj1);
    end
    
    adj2_1_index = find(adj2==fib1);
    if adj2_1_index > 0
        adj2(adj2_1_index) = [];
        handles.temp.data.adj{fib2} = num2cell(adj2);
    end
    
    logText = get(handles.log,'String');
    logText{end+1,:} = [' Removed link between fibers ',num2str(fib1),' and ',num2str(fib2)];
    set(handles.log,'string',logText);
catch
end
overlayLabels(handles.temp.data,1);
guidata(hObject,handles);



% --- Executes on button press in addButton.
function addButton_Callback(hObject, eventdata, handles)
% hObject    handle to addButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    handles.temp.data;
catch
    disp('Please check if the required data csv file is loaded');
    return;
end

fib3 = str2double(get(handles.edit3,'String'));
fib4 = str2double(get(handles.edit4,'String'));
try
    imshow(handles.temp.data.image);
    adj3 = cell2mat(handles.temp.data.adj{fib3});
    adj4 = cell2mat(handles.temp.data.adj{fib4});
    if sum(adj3==fib4)==0
        adj3 = [adj3 fib4];
        handles.temp.data.adj{fib3} = num2cell(adj3);
    end
    if sum(adj4==fib3)==0
        adj4 = [adj4 fib3];
        handles.temp.data.adj{fib4} = num2cell(adj4);
    end
    cla;imshow(handles.temp.data.image);
    overlayLabels(handles.temp.data,1);
    logText = get(handles.log,'String');
    logText{end+1,:} = [' Added link between fibers ',num2str(fib3),' and ',num2str(fib4)];
    set(handles.log,'string',logText);
catch
end
guidata(hObject,handles);



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



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in loadButton.
function loadButton_Callback(hObject, eventdata, handles)
% hObject    handle to loadButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, foldername] = uigetfile('*.mat', 'Select a mat file');
fullname = fullfile(foldername, filename);
temp = load(fullname);
handles.temp = temp;
imshow(temp.data.image);
set(gca,'XTick',[],'YTick',[]);
hold on;
overlayLabels(temp.data,1);
logText = get(handles.log,'String');
%lineToAdd = [' Loaded .mat data file - ',filename];
%logText = {logText;lineToAdd};
logText{end+1,:} = [' Loaded .mat data file - ',filename];
set(handles.log,'string',logText);
set(handles.hideLinesCheckBox,'enable','on');
guidata(hObject,handles)


% --- Executes on button press in ProcessCsv.
function ProcessCsv_Callback(hObject, eventdata, handles)
% hObject    handle to ProcessCsv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
threshold = 0.2;
[filename, foldername] = uigetfile('*.csv', 'Select a csv file');
fullname = fullfile(foldername, filename);
[adj, centroids, feret_dia, fiberColors] = processCsvForGui(fullname,threshold,[],false);
handles.temp.data.adj = adj;
handles.temp.data.centroids = centroids;
handles.temp.data.feret_dia = feret_dia;
handles.temp.data.fiberColors = fiberColors;
overlayLabels(handles.temp.data,1);
logText = get(handles.log,'String');
logText{end+1,:} = [' Loaded .csv data file - ',filename];
set(handles.log,'string',logText);
handles.temp.data.csvFileName = fullname;
set(handles.hideLinesCheckBox,'enable','on');
guidata(hObject,handles)



% --- Executes on button press in loadNewImage.
function loadNewImage_Callback(hObject, eventdata, handles)
% hObject    handle to loadNewImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla;
handles.temp = {};
[filename, foldername] = uigetfile({'*.TIF';'*.png';'*.jpg';'*.jpeg';'*.tiff';'*.tif';}, 'Select an image file');
fullname = fullfile(foldername, filename);
tmp_fig = imread(fullname);
if size(tmp_fig,3) > 3
    tmp_fig = tmp_fig(:,:,1:3);
end
tmp_fig = imresize(tmp_fig,[1024 1024]);
imshow(tmp_fig); 
logText = get(handles.log,'string');
%lineToAdd = {[' Loaded .new Image file - ',filename]};
%logText = [logText;lineToAdd];
logText{end+1,:} = [' Loaded new Image file - ',filename];
set(handles.log,'string',logText);
handles.temp.data.image = tmp_fig;
handles.temp.data.origImage = tmp_fig;
handles.temp.data.imageFileName = fullname;
guidata(hObject,handles)



function log_Callback(hObject, eventdata, handles)
% hObject    handle to log (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of log as text
%        str2double(get(hObject,'String')) returns contents of log as a double


% --- Executes during object creation, after setting all properties.
function log_CreateFcn(hObject, eventdata, handles)
% hObject    handle to log (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in resetButton.
function resetButton_Callback(hObject, eventdata, handles)
% hObject    handle to resetButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla;
handles.temp = {};
logText = get(handles.log,'String');
%lineToAdd = ' Data reset! ';
%logText = {logText;lineToAdd};
logText{end+1,:} = [' Data reset!'];
set(handles.log,'string',logText);
set(handles.log,'string',{['Event log']});
set(handles.hideLinesCheckBox,'enable','inactive');
guidata(hObject,handles);


% --- Executes on button press in saveMat.
function saveMat_Callback(hObject, eventdata, handles)
% hObject    handle to saveMat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = handles.temp.data;
uisave('data');
logText = get(handles.log,'string');
logText{end+1,:} = [' Saved data to new .mat file'];
set(handles.log,'string',logText);


% --- Executes on slider movement.
function brightnessSlider_Callback(hObject, eventdata, handles)
% hObject    handle to brightnessSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
brightness = get(handles.brightnessSlider,'Value');
tmpFig = imadjust(handles.temp.data.origImage,[0; 1],[brightness;1-brightness]);
cla;
imshow(tmpFig);
handles.temp.data.image = tmpFig;
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function brightnessSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to brightnessSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function thresholdSlider_Callback(hObject, eventdata, handles)
% hObject    handle to thresholdSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
threshold = get(handles.thresholdSlider,'Value');
cla;
imshow(handles.temp.data.image);
[adj, centroids, feret_dia, fiberColors] = processCsvForGui(handles.temp.data.csvFileName,threshold);
handles.temp.data.fiberColors = fiberColors;
handles.temp.data.adj = adj;
handles.temp.data.centroids = centroids;
handles.temp.data.feret_dia = feret_dia;
overlayLabels(handles.temp.data,1);
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function thresholdSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thresholdSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in hideLinesCheckBox.
function hideLinesCheckBox_Callback(hObject, eventdata, handles)
% hObject    handle to hideLinesCheckBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hideLinesCheckBox
hideLines = 1-get(handles.hideLinesCheckBox,'Value');
threshold = get(handles.thresholdSlider,'Value');
cla;
imshow(handles.temp.data.image);
overlayLabels(handles.temp.data,hideLines);
guidata(hObject,handles);
