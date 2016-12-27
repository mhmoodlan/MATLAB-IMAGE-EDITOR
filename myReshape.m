function myReshape(handles)
%RESHAPE Summary of this function goes here
%   Detailed explanation goes here
global image;
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
global indexedY;
global indexedMap;
global imageTransformsIndex;
global imageTransforms;
global isMapped;
global width;
global height;
global whIndex;


editImage = image;

%crop
if isCropped == 1
    editImage = croppedImage;
end

%transformation functions

for i = 1:imageTransformsIndex
   u = imageTransforms(i);
   switch u
        case 6 %ind2gray
            editImage = ind2gray(indexedY, indexedMap);
            colorType = 'grayscale';
        case 7 %gray2ind
            [indexedY, indexedMap] = gray2ind(editImage, 256);
            colorType = 'indexed';
        case 8 %rgb2gray
            editImage = rgb2gray(editImage);
            colorType = 'grayscale';
        case 9 %gray2rgb
            %editImage= gray2rgb(editImage);
            colorType = 'truecolor'; 
        case 10 %rgb2ind
            [indexedY, indexedMap] = rgb2ind(editImage, 256);
            colorType = 'indexed';
        case 11 %ind2rgb
            editImage = ind2rgb(indexedY, indexedMap);
            colorType = 'truecolor';
   end
end

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

if isGrayscale == 1
    set(handles.popupmenu2, 'Enable', 'on');
    set(handles.pushbutton29, 'Enable', 'on'); 
     
else    
    set(handles.popupmenu2, 'Enable', 'off');
    set(handles.pushbutton29, 'Enable', 'off');
    set(handles.popupmenu2, 'Value', 1);
end

if isTruecolor == 1
    set(handles.checkbox7, 'Enable', 'on');
    set(handles.checkbox6, 'Enable', 'on'); 
     
else    
    set(handles.checkbox7, 'Enable', 'off');
    set(handles.checkbox6, 'Enable', 'off');
    set(handles.checkbox7, 'Value', 0);
    set(handles.checkbox6, 'Value', 0);
end

set(handles.text14, 'string', colorType);

%brightness
editImage = imadd(editImage, brightness(brightnessIndex)*25);

%contrast
if contrast(contrastIndex) > 0
    editImage = immultiply(editImage, contrast(contrastIndex)*2.55);
elseif contrast(contrastIndex) < 0
    editImage = imdivide(editImage, -1*contrast(contrastIndex)*2.55);
end

%resolution
if resolution(resolutionIndex) > 0
    editImage = imresize(editImage, resolution(resolutionIndex)/100);
else
    editImage = imresize(editImage, 0.001);
end

%rotation
editImage = imrotate(editImage, rotation(rotationIndex)*-1);

%resize
if resize(resizeIndex) > 0
    editImage = imresize(editImage ,resize(resizeIndex)/100);
else
    editImage = imresize(editImage, 0.001);
end

% new resize
editImage = imresize(editImage, [height(whIndex) width(whIndex)]);

%flip
if flippedH == 1
    editImage = imrotate(editImage , 180);
end
if flippedV == 1
    editImage = flipdim(editImage, 2);
end


x = strcmp(colorType, 'truecolor');
if x == 1
    y = get(handles.checkbox7, 'Value');
    if y == 1
        editImage = rgb2ntsc(editImage) ;
    end
    y = get(handles.checkbox6, 'Value');
    if y == 1
        editImage = rgb2hsv(editImage) ;
    end
end

axes(handles.axes4);
imshow(editImage)


% color mappping
x = strcmp(colorType, 'grayscale');
if x == 1 && isMapped == 1
        s = get(handles.popupmenu2,'Value');
        axes(handles.axes4);
        s = s-1;
        switch s 
            case 1 
                colormap hsv;
            case 2
                colormap hot;
            case 3 
                colormap gray ;
            case 4
                colormap bone;
            case 5 
                colormap copper;
            case 6
                colormap pink;
            case 7 
                colormap white;
            case 8
                colormap flag;
            case 9 
                colormap lines;
            case 10
                colormap colorcube;
            case 11 
                colormap vga;
            case 12
                colormap jet;
            case 13
                colormap prism;
            case 14 
                colormap cool;
            case 15
                colormap autumn;
            case 16 
                colormap spring;
            case 17
                colormap winter;
            case 18
                colormap summer;
        end
end



end

