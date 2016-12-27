function varargout = browse(varargin)
% BROWSE MATLAB code for browse.fig
%      BROWSE, by itself, creates a new BROWSE or raises the existing
%      singleton*.
%
%      H = BROWSE returns the handle to a new BROWSE or the handle to
%      the existing singleton*.
%
%      BROWSE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BROWSE.M with the given input arguments.
%
%      BROWSE('Property','Value',...) creates a new BROWSE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before browse_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to browse_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Our global variables :
global image;
global editImage;
global actions;
global actionsIndex;
global brightness;
global brightnessIndex;
global contrast;
global contrastIndex;
global resolution;
global resolutionIndex;
global rotation;
global rotationIndex;
global resize;
global resizeIndex;
global flippedH;
global flippedV;
global isCropped;
global croppedImage;

global colorType;
global imageTransformsIndex;
global imageTransforms;

global mappedImage;
global isMapped;

% Edit the above text to modify the response to help browse

% Last Modified by GUIDE v2.5 25-Dec-2016 20:04:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @browse_OpeningFcn, ...
                   'gui_OutputFcn',  @browse_OutputFcn, ...
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


% --- Executes just before browse is made visible.
function browse_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to browse (see VARARGIN)

% Choose default command line output for browse
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes browse wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = browse_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton.
function pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image ;
global editImage;
global actionsIndex;
global brightness;
global brightnessIndex;
global contrast;
global contrastIndex;
global resolutionIndex;
global resolution;
global rotation;
global rotationIndex;
global resize;
global resizeIndex;
global flippedH;
global flippedV;
global isCropped;
global croppedImage;
global colorType;
global indexedY;
global indexedMap;
global imageTransformsIndex;

global mappedImage;
global isMapped;


global height ;
global width;
global whIndex;


global originalHeight ;
global originalWidth;

[filename filepath]=uigetfile({'*.jpg';'*.png';'*.bmp'; '*.tif'},'File Selector');
raw = strcat(filepath,filename);
info = imfinfo(raw);
image = imread(raw);
originalWidth = info.Height;
originalHeight = info.Width;
width(1) = originalHeight;
height(1) = originalWidth;
whIndex = 1;
editImage = image;
actionsIndex = 0;
brightness(1) = 0;
brightnessIndex = 1;
contrast(1) = 0;
contrastIndex = 1;
resolution(1) = 100;
resolutionIndex = 1;
rotationIndex = 1;
rotation(rotationIndex) = 0;
resize(1) = 100;
resizeIndex = 1;
flippedH = 0;
flippedV = 0;
isCropped = 0;
croppedImage = image;
colorType = info(1).ColorType;
mappedImage = image;
isMapped = 0;

imageTransformsIndex = 0;

isIndexed = strcmp(colorType, 'indexed');
if isIndexed == 1
    [indexedY, indexedMap] = imread(raw);
end

set(handles.text14, 'string', colorType);
axes(handles.axes1);
imshow(image);
axes(handles.axes4);
imshow(image);
set(handles.edit1,'string',filepath);
set(handles.edit2,'string',filename);

set(handles.edit16,'string',width);
set(handles.edit15,'string',height);

isGrayscale = strcmp(colorType, 'grayscale');
isTruecolor = strcmp(colorType, 'truecolor');
isIndexed = strcmp(colorType, 'indexed');
if isGrayscale == 1
    set(handles.radiobutton1, 'Enable', 'off');
    set(handles.radiobutton2, 'Enable', 'off');
    set(handles.radiobutton3, 'Enable', 'off');
    set(handles.radiobutton5, 'Enable', 'off');
    
    set(handles.radiobutton4, 'Enable', 'on');
    set(handles.radiobutton6, 'Enable', 'on');
    set(handles.radiobutton6, 'Value', 1.0);
    
elseif isTruecolor == 1
    set(handles.radiobutton1, 'Enable', 'off');
    set(handles.radiobutton4, 'Enable', 'off');
    set(handles.radiobutton6, 'Enable', 'off');
    set(handles.radiobutton5, 'Enable', 'off');
    
    set(handles.radiobutton2, 'Enable', 'on');
    set(handles.radiobutton3, 'Enable', 'on');
    set(handles.radiobutton3, 'Value', 1.0);
elseif isIndexed == 1
    set(handles.radiobutton4, 'Enable', 'off');
    set(handles.radiobutton2, 'Enable', 'off');
    set(handles.radiobutton3, 'Enable', 'off');
    set(handles.radiobutton6, 'Enable', 'off');
    
    set(handles.radiobutton1, 'Enable', 'on');
    set(handles.radiobutton5, 'Enable', 'on');
    set(handles.radiobutton5, 'Value', 1.0);
end
x = strcmp(colorType, 'grayscale');
if x ~= 1
    set(handles.popupmenu2, 'Enable', 'off');
    set(handles.pushbutton29, 'Enable', 'off');
end
x = strcmp(colorType, 'truecolor');
if x ~= 1    
    set(handles.checkbox7, 'Enable', 'off');
    set(handles.checkbox6, 'Enable', 'off');
    set(handles.checkbox7, 'Value', 0);
    set(handles.checkbox6, 'Value', 0);
end


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



% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
global flippedH;

if flippedH == 0
    flippedH = 1;
else
    flippedH = 0;
end

myReshape(handles);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%imwrite(image , 'H:\');
[filename, pathname] = uiputfile('*.m',...
                       'Pick a MATLAB program file');
if isequal(filename,0) || isequal(pathname,0)
   
else
        F = getframe(handles.axes4);
        finalimage = frame2im(F);
        outfile = fullfile(pathname,filename);
        imwrite(finalimage, outfile);
end


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global isCropped;
global image;
global croppedImage;
isCropped = 1;
axes(handles.axes1);
croppedImage = imcrop(image);
myReshape(handles);

% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3
global flippedV;

if flippedV == 0
    flippedV = 1;
else
    flippedV = 0;
end

myReshape(handles);


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
global isMapped;

isMapped = 1;

myReshape(handles);



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


% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider9_Callback(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider10_Callback(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global actions;
global actionsIndex;
global resolution;
global resolutionIndex;

percentage = get(handles.slider10,'Value'); 
resolutionIndex = resolutionIndex + 1;
resolution(resolutionIndex) = percentage;
actionsIndex = actionsIndex + 1;
actions(actionsIndex) = 3;

myReshape(handles);

% --- Executes during object creation, after setting all properties.
function slider10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global actions;
global actionsIndex;
global brightness;
global brightnessIndex;
global contrast;
global contrastIndex;
global resolutionIndex;
global resolution;
global rotation;
global rotationIndex;
global resize;
global resizeIndex;
global whIndex;
global width;
global height;
global colorType;
global imageTransformsIndex;

if actionsIndex > 0
    action = actions(actionsIndex);
    actionsIndex = actionsIndex - 1;
    switch action
        case 1 %brightness
            brightnessIndex = brightnessIndex - 1;
            set(handles.edit9, 'Value', brightness(brightnessIndex));
            set(handles.edit9, 'string', brightness(brightnessIndex));
        case 2 %contrast
            contrastIndex = contrastIndex - 1;
            set(handles.edit10, 'Value', contrast(contrastIndex));
            set(handles.edit10, 'string', contrast(contrastIndex));
        case 3 %resolution
            resolutionIndex = resolutionIndex - 1;
            set(handles.edit11, 'Value', resolution(resolutionIndex));
            set(handles.edit11, 'string', resolution(resolutionIndex));
        case 4 %rotation
            rotationIndex = rotationIndex - 1;
            set(handles.edit12, 'Value', rotation(rotationIndex));
            set(handles.edit12, 'string', rotation(rotationIndex));
        case 5 %resize
            resizeIndex = resizeIndex - 1;
            set(handles.edit14, 'Value', resize(resizeIndex));
            set(handles.edit14, 'string', resize(resizeIndex));
        case 6 %ind2gray
            imageTransformsIndex = imageTransformsIndex - 1;
            colorType = 'indexed';
        case 7 %gray2ind
            imageTransformsIndex = imageTransformsIndex - 1;
            colorType = 'grayscale';
        case 8 %rgb2gray
            imageTransformsIndex = imageTransformsIndex - 1;
            colorType = 'truecolor';
        case 9 %gray2rgb
            imageTransformsIndex = imageTransformsIndex - 1;
            colorType = 'grayscale';
        case 10 %rgb2ind
            imageTransformsIndex = imageTransformsIndex - 1;
            colorType = 'truecolor';
        case 11 %ind2rgb
            imageTransformsIndex = imageTransformsIndex - 1;
            colorType = 'indexed';
        case 12
            whIndex = whIndex - 1;
            set(handles.edit16, 'string', width(whIndex));
            set(handles.edit15, 'string', height(whIndex));
    end
        
    myReshape(handles);
end

% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
global actions;
global actionsIndex;
global brightness;
global brightnessIndex;
global contrast;
global contrastIndex;
global resolutionIndex;
global resolution;
global rotation;
global rotationIndex;
global resize;
global resizeIndex;
global width;
global height;
global whIndex;
global colorType;
global imageTransformsIndex;

if actionsIndex < size(actions, 2)
    actionsIndex = actionsIndex + 1;
    action = actions(actionsIndex);
 
    switch action
        case 1 %brightness
            brightnessIndex = brightnessIndex + 1;
            set(handles.edit9, 'Value', brightness(brightnessIndex));
            set(handles.edit9, 'string', brightness(brightnessIndex));
        case 2 %contrast
            contrastIndex = contrastIndex + 1;
            set(handles.edit10, 'Value', contrast(contrastIndex));
            set(handles.edit10, 'string', contrast(contrastIndex));
        case 3 %resolution
            resolutionIndex = resolutionIndex + 1;
            set(handles.edit11, 'Value', resolution(resolutionIndex));
            set(handles.edit11, 'string', resolution(resolutionIndex));
        case 4 %rotation
            rotationIndex = rotationIndex + 1;
            set(handles.edit12, 'Value', rotation(rotationIndex));
            set(handles.edit12, 'string', rotation(rotationIndex));
        case 5 %resize
            resizeIndex = resizeIndex + 1;
            set(handles.edit14, 'Value', resize(resizeIndex));
            set(handles.edit14, 'string', resize(resizeIndex));
        case 6 %ind2gray
            imageTransformsIndex = imageTransformsIndex + 1;
            colorType = 'indexed';
        case 7 %gray2ind
            imageTransformsIndex = imageTransformsIndex + 1;
            colorType = 'grayscale';
        case 8 %rgb2gray
            imageTransformsIndex = imageTransformsIndex + 1;
            colorType = 'truecolor';
        case 9 %gray2rgb
            imageTransformsIndex = imageTransformsIndex + 1;
            colorType = 'grayscale';
        case 10 %rgb2ind
            imageTransformsIndex = imageTransformsIndex + 1;
            colorType = 'truecolor';
        case 11 %ind2rgb
            imageTransformsIndex = imageTransformsIndex + 1;
            colorType = 'indexed';
        case 12
            whIndex = whIndex + 1;
            set(handles.edit16, 'string', width(whIndex));
            set(handles.edit15, 'string', height(whIndex));
            
    end
        
    myReshape(handles);
end

function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global actionsIndex;
global actions;
global brightness;
global brightnessIndex;

k =get(handles.edit9,'Value');
if k < 6
    k = (k + 1);
    set(handles.edit9,'Value',k);
    set(handles.edit9,'string',k);
    brightnessIndex = brightnessIndex + 1;
    brightness(brightnessIndex) = k;
    actionsIndex = actionsIndex + 1;
    actions(actionsIndex) = 1;
    myReshape(handles);
end

% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global actions;
global actionsIndex;
global brightness;
global brightnessIndex;

k =get(handles.edit9,'Value');
if k > -6
    k = (k - 1);
    set(handles.edit9,'Value',k);
    set(handles.edit9,'string',k);
    brightnessIndex = brightnessIndex + 1;
    brightness(brightnessIndex) = k;
    actionsIndex = actionsIndex + 1;
    actions(actionsIndex) = 1;
    myReshape(handles);
end


function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global actions;
global actionsIndex;
global contrast;
global contrastIndex;

k = get(handles.edit10,'Value');
if k < 10
    k = (k + 1);
    set(handles.edit10,'Value',k);
    set(handles.edit10,'string',k);
    contrastIndex = contrastIndex + 1;
    contrast(contrastIndex) = k;
    actionsIndex = actionsIndex + 1;
    actions(actionsIndex) = 2;
    myReshape(handles);
end

% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global actions;
global actionsIndex;
global contrast;
global contrastIndex;

k =get(handles.edit10,'Value');
if k > -10
    k = (k - 1);
    set(handles.edit10,'Value',k);
    set(handles.edit10,'string',k);
    contrastIndex = contrastIndex + 1;
    contrast(contrastIndex) = k;
    actionsIndex = actionsIndex + 1;
    actions(actionsIndex) = 2;
    myReshape(handles);
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global actions;
global actionsIndex;
global resolution;
global resolutionIndex;

percentage = get(handles.edit11,'Value');
percentage = percentage+10;
if percentage <= 100
    set(handles.edit11,'Value', percentage);
    set(handles.edit11,'string', percentage);
    resolutionIndex = resolutionIndex + 1;
    resolution(resolutionIndex) = percentage;
    actionsIndex = actionsIndex + 1;
    actions(actionsIndex) = 3;
    myReshape(handles);
end

% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global actions;
global actionsIndex;
global resolution;
global resolutionIndex;

percentage = get(handles.edit11,'Value');
percentage = percentage - 10;
if percentage >= 0
    set(handles.edit11,'Value', percentage);
    set(handles.edit11,'string', percentage);
    resolutionIndex = resolutionIndex + 1;
    resolution(resolutionIndex) = percentage;
    actionsIndex = actionsIndex + 1;
    actions(actionsIndex) = 3;
    myReshape(handles);
end

function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global actions;
global actionsIndex;
global rotation;
global rotationIndex;

angle = get(handles.edit12,'Value');
angle = angle + 5;
if angle <= 360
    rotationIndex = rotationIndex + 1;
    rotation(rotationIndex) = angle;
    actionsIndex = actionsIndex + 1;
    actions(actionsIndex) = 4;
    set(handles.edit12,'string',angle);
    set(handles.edit12,'Value',angle);
    myReshape(handles);
end

% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global actions;
global actionsIndex;
global rotation;
global rotationIndex;

angle = get(handles.edit12,'Value');
angle = angle - 5;
if angle >= 0
    rotationIndex = rotationIndex + 1;
    rotation(rotationIndex) = angle;
    actionsIndex = actionsIndex + 1;
    actions(actionsIndex) = 4;
    set(handles.edit12,'string',angle);
    set(handles.edit12,'Value',angle);
    myReshape(handles);
end

function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global actions;
global actionsIndex;
global resize;
global resizeIndex;

percentage = get(handles.edit14,'Value');  
percentage = percentage + 10;
if percentage <= 100
    resizeIndex = resizeIndex + 1;
    resize(resizeIndex) = percentage;
    actionsIndex = actionsIndex + 1;
    actions(actionsIndex) = 5;
    set(handles.edit14,'string',percentage);
    set(handles.edit14,'Value',percentage);    
    myReshape(handles);
end

% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global actions;
global actionsIndex;
global resize;
global resizeIndex;

percentage = get(handles.edit14,'Value');  
percentage = percentage - 10;
if percentage >= 0
    resizeIndex = resizeIndex + 1;
    resize(resizeIndex) = percentage;
    actionsIndex = actionsIndex + 1;
    actions(actionsIndex) = 5;
    set(handles.edit14,'string',percentage);
    set(handles.edit14,'Value',percentage);    
    myReshape(handles);
end


function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global isCropped;
isCropped = 0;
myReshape(handles);


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3

global isind2gray;
global isgray2ind;
global isrgb2gray;
global isgray2rgb;
global isind2rgb;
global isrgb2ind;
global actions;
global actionsIndex;

contents = cellstr(get(hObject,'String'));
content = contents{get(hObject,'Value')};
switch content
    case 'ind2gray'
        isind2gray = 1;
        actionsIndex = actionsIndex + 1;
        actions(actionsIndex) = 6;
    case 'gray2ind'
        isgray2ind = 1;
        actionsIndex = actionsIndex + 1;
        actions(actionsIndex) = 7;
    case 'rgb2gray'
        isrgb2gray = 1;
        actionsIndex = actionsIndex + 1;
        actions(actionsIndex) = 8;
    case 'gray2rgb'
        isgray2rgb = 1;
        actionsIndex = actionsIndex + 1;
        actions(actionsIndex) = 9;
    case 'rgb2ind'
        isrgb2ind = 1;
        actionsIndex = actionsIndex + 1;
        actions(actionsIndex) = 10;
    case 'ind2rgb'
        isind2rgb = 1;
        actionsIndex = actionsIndex + 1;
        actions(actionsIndex) = 11;
end

myReshape(handles);


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


% --- Executes on button press in radiobutton4.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5


% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6


% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global imageTransformsIndex;
global imageTransforms;
global actions;
global actionsIndex;

u = get(get(handles.uipanel8,'SelectedObject'), 'string');
switch u
    case 'ind2gray'
        imageTransformsIndex = imageTransformsIndex + 1;
        imageTransforms(imageTransformsIndex) = 6;
        actionsIndex = actionsIndex + 1;
        actions(actionsIndex) = 6;
    case 'gray2ind'
        imageTransformsIndex = imageTransformsIndex + 1;
        imageTransforms(imageTransformsIndex) = 7;
        actionsIndex = actionsIndex + 1;
        actions(actionsIndex) = 7;
    case 'rgb2gray'
        imageTransformsIndex = imageTransformsIndex + 1;
        imageTransforms(imageTransformsIndex) = 8;
        actionsIndex = actionsIndex + 1;
        actions(actionsIndex) = 8;
    case 'gray2rgb'
        imageTransformsIndex = imageTransformsIndex + 1;
        imageTransforms(imageTransformsIndex) = 9;
        actionsIndex = actionsIndex + 1;
        actions(actionsIndex) = 9;
    case 'rgb2ind'
        imageTransformsIndex = imageTransformsIndex + 1;
        imageTransforms(imageTransformsIndex) = 10;
        actionsIndex = actionsIndex + 1;
        actions(actionsIndex) = 10;
    case 'ind2rgb'
        imageTransformsIndex = imageTransformsIndex + 1;
        imageTransforms(imageTransformsIndex) = 11;
        actionsIndex = actionsIndex + 1;
        actions(actionsIndex) = 11;
end

myReshape(handles);

% --- Executes when selected object is changed in uipanel8.
function uipanel8_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel8 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function uipanel8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function radiobutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function radiobutton2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function radiobutton3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function radiobutton4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function radiobutton5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function radiobutton6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
clear all;
clc;


% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global isMapped;
isMapped = 0;
myReshape(handles);


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6
myReshape(handles);

% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7
myReshape(handles);



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double
global actions;
global actionsIndex;
global width;
global height;
global whIndex;

h = str2double(get(handles.edit15, 'string'));
w = str2double(get(handles.edit16, 'string'));
if (~isempty(w) && ~isempty(h))
    if(h<6000 || w<6000)
        whIndex = whIndex + 1;
        actionsIndex = actionsIndex + 1;
        actions(actionsIndex) = 12;
        width(whIndex) = w;
        height(whIndex) = h;
        myReshape(handles);
    end
end

% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double
global actions;
global actionsIndex;
global width;
global height;
global whIndex;

h = str2double(get(handles.edit15, 'string'));
w = str2double(get(handles.edit16, 'string'));
if (~isempty(w) && ~isempty(h))
    if(h<6000 || w<6000)
        whIndex = whIndex + 1;
        actionsIndex = actionsIndex + 1;
        actions(actionsIndex) = 12;
        width(whIndex) = w;
        height(whIndex) = h;
        myReshape(handles);
    end
end

% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
