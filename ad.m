function varargout = ad(varargin)
% AD MATLAB code for ad.fig
%      AD, by itself, creates a new AD or raises the existing
%      singleton*.
%
%      H = AD returns the handle to a new AD or the handle to
%      the existing singleton*.
%
%      AD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AD.M with the given input arguments.
%
%      AD('Property','Value',...) creates a new AD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ad_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ad_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ad

% Last Modified by GUIDE v2.5 02-Apr-2012 21:03:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ad_OpeningFcn, ...
                   'gui_OutputFcn',  @ad_OutputFcn, ...
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


% --- Executes just before ad is made visible.
function ad_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ad (see VARARGIN)

% Choose default command line output for ad
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ad wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ad_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clc;
global a;
global main;
X = uigetfile('*.jpg;*.tiff;*.ppm;*.pgm;*.png','pick a jpge file');
a = imread(X);
main=a;
a = imresize(a,[200 200]);
axes(handles.axes1)
imshow(a);



function Textbox_Callback(hObject, eventdata, handles)
% hObject    handle to keybox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of keybox as text
%        str2double(get(hObject,'String')) returns contents of keybox as a double

global d;
d=str2num(get(handles.Textbox,'String'));



% --- Executes during object creation, after setting all properties.
function Textbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to keybox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function keybox_Callback(hObject, eventdata, handles)
% hObject    handle to keybox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of keybox as text
%        str2double(get(hObject,'String')) returns contents of keybox as a double

global kk;
kk=str2num(get(handles.keybox,'String'));


% --- Executes during object creation, after setting all properties.
function keybox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to keybox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global a;
global d;
global dcry;

for i=1:200
    for j=1:200
        for k=1:3
            b=dec2bin(a(i,j,k),8);
            % Converting each pixel from decimal to binary and adding
            % zeroes to make it 8 but
            
            for l=1:8
                c(l)=b(d(l));
                % Rearranging bits to according to the key entered %
            end
            e(i,j,k)=bin2dec(c);
            % Inserting the permuted value back into its respective pixel % 
        end
    end
end
enimg=uint8(e);
% Converting from indexed to intensity image %


% 2 stage Encryption : Encryption using pixel manupulation %

l=1;
n=1;
m=1;
x=1;

for i=1:200
    for j=1:200
        for k=1:3
            b1(i,l,k)=enimg(i,j,k);
            % Transfering 8 pixels of encrypted image to new matrix b1 %
        end
        
        l=l+1;
        if(l>8)
            for n=1:8
                for m=1:3
                    e1(i,x,m)=b1(i,d(n),m);
                    % Permuting 8 pixels present in b1 and transferring to
                    % new image e1
                end
                x=x+1;
            end
            l=1;
        else
        end
    end
    x=1;
end


% 3 stage encryption : Encryption using block permutation %


a1=e1(1:20,1:200,1:3);
a2=e1(21:40,1:200,1:3);
a3=e1(41:60,1:200,1:3);
a4=e1(61:80,1:200,1:3);
a5=e1(81:100,1:200,1:3);
a6=e1(101:120,1:200,1:3);
a7=e1(121:140,1:200,1:3);
a8=e1(141:160,1:200,1:3);
a9=e1(161:180,1:200,1:3);
a10=e1(181:200,1:200,1:3);
% aDividing image into 8 horizontal blocks %
at=[a3;a5;a4;a1;a6;a2;a8;a7;a10;a9];
% Rearranging sequence of blocks %

e1=at(1:200,1:20,1:3);
e2=at(1:200,21:40,1:3);
e3=at(1:200,41:60,1:3);
e4=at(1:200,61:80,1:3);
e5=at(1:200,81:100,1:3);
e6=at(1:200,101:120,1:3);
e7=at(1:200,121:140,1:3);
e8=at(1:200,141:160,1:3);
e9=at(1:200,161:180,1:3);
e10=at(1:200,181:200,1:3);

% Splitting image into 8 vertical blocks %
eg=[e3 e5 e4 e1 e6 e2 e8 e7 e10 e9];
% Rearranging sequence of blocks to obtain final encrypted image %
dcry=eg;
axes(handles.axes2)
imshow(eg);



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global kk;
global a;
img=a;
global img1;
global img22;


l1=2;
q1=1;
l2=15;
q2=14;
l3=28;
q3=27;
l=1;
k1=zeros(1,40);
% key encryption
for i=1:39

if(mod(i,4)==0)
q1=q1+1;
l1=q1+1;

q2=q2+1;
l2=q2+1;

q3=q3+1;
l3=q3+1;
end

a11(i)=bitxor(kk(q1),kk(l1));
l1=l1+1;
a(i)=bitxor(a11(i),kk(l1));

b11(i)=bitxor(kk(q2),kk(l2));
l2=l2+1;
b(i)=bitxor(b11(i),kk(l2));

c11(i)=bitxor(kk(q3),kk(l3));
l3=l3+1;
c22(i)=bitxor(c11(i),kk(l3));

end

for i=1:39
    t(i)=bitxor(a11(i),b11(i));
    k1(i)=bitxor(c11(i),t(i));
end
k1(1,40)=bitxor(k1(1,38),k1(1,39));
t1=circshift(k1',20);
z=t1';

% encryption step 4

for p=1:10
    
    w1=img(1:100,1:100,1:3);
w2=img(101:200,1:100,1:3);
w3=img(1:100,101:200,1:3);
w4=img(101:200,101:200,1:3);
img=[w4 w2;w3 w1];
for i=1:200
    for j=1:200
        for k=1:3
            if(mod(p,2)==0)
            
            if(j==1||l==1)
            c22(i,j,k)=bitxor(img(i,j,k),k1(l));
            img(i,j,k)=c22(i,j,k);
            else
            c22(i,j,k)=bitxor(img(i,j-1,k),img(i,j,k));
            img(i,j,k)=bitxor(k1(l),c22(i,j,k));
            end
           
            else
                if(j==1||l==1)
            c22(i,j,k)=bitxor(img(i,j,k),z(l));
            img(i,j,k)=c22(i,j,k);
            else
            c22(i,j,k)=bitxor(img(i,j-1,k),img(i,j,k));
            img(i,j,k)=bitxor(z(l),c22(i,j,k));
                end
            end

        end
             l=l+1;
 if(l>40)
     l=1;
 end
      
    end
end
end
axes(handles.axes3)
imshow(img)
img22=img;
img1=img;

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global a;
global d;
global kk;
global img2;
global img33;


for i=1:200
    for j=1:200
        for k=1:3
            b=dec2bin(a(i,j,k),8);
            % Converting each pixel from decimal to binary and adding
            % zeroes to make it 8 but
            
            for l=1:8
                c(l)=b(d(l));
                % Rearranging bits to according to the key entered %
            end
            e(i,j,k)=bin2dec(c);
            % Inserting the permuted value back into its respective pixel % 
        end
    end
end
enimg=uint8(e);
% Converting from indexed to intensity image %


% 2 stage Encryption : Encryption using pixel manupulation %

l=1;
n=1;
m=1;
x=1;

for i=1:200
    for j=1:200
        for k=1:3
            b1(i,l,k)=enimg(i,j,k);
            % Transfering 8 pixels of encrypted image to new matrix b1 %
        end
        
        l=l+1;
        if(l>8)
            for n=1:8
                for m=1:3
                    e1(i,x,m)=b1(i,d(n),m);
                    % Permuting 8 pixels present in b1 and transferring to
                    % new image e1
                end
                x=x+1;
            end
            l=1;
        else
        end
    end
    x=1;
end


% 3 stage encryption : Encryption using block permutation %


a1=e1(1:20,1:200,1:3);
a2=e1(21:40,1:200,1:3);
a3=e1(41:60,1:200,1:3);
a4=e1(61:80,1:200,1:3);
a5=e1(81:100,1:200,1:3);
a6=e1(101:120,1:200,1:3);
a7=e1(121:140,1:200,1:3);
a8=e1(141:160,1:200,1:3);
a9=e1(161:180,1:200,1:3);
a10=e1(181:200,1:200,1:3);
% aDividing image into 8 horizontal blocks %
at=[a3;a5;a4;a1;a6;a2;a8;a7;a10;a9];
% Rearranging sequence of blocks %

e1=at(1:200,1:20,1:3);
e2=at(1:200,21:40,1:3);
e3=at(1:200,41:60,1:3);
e4=at(1:200,61:80,1:3);
e5=at(1:200,81:100,1:3);
e6=at(1:200,101:120,1:3);
e7=at(1:200,121:140,1:3);
e8=at(1:200,141:160,1:3);
e9=at(1:200,161:180,1:3);
e10=at(1:200,181:200,1:3);

% Splitting image into 8 vertical blocks %
eg=[e3 e5 e4 e1 e6 e2 e8 e7 e10 e9];
% Rearranging sequence of blocks to obtain final encrypted image %



l1=2;
q1=1;
l2=15;
q2=14;
l3=28;
q3=27;

k1=zeros(1,40);
% key encryption
for i=1:39

if(mod(i,4)==0)
q1=q1+1;
l1=q1+1;

q2=q2+1;
l2=q2+1;

q3=q3+1;
l3=q3+1;
end

a11(i)=bitxor(kk(q1),kk(l1));
l1=l1+1;
a(i)=bitxor(a11(i),kk(l1));

b11(i)=bitxor(kk(q2),kk(l2));
l2=l2+1;
b(i)=bitxor(b11(i),kk(l2));

c11(i)=bitxor(kk(q3),kk(l3));
l3=l3+1;
c22(i)=bitxor(c11(i),kk(l3));

end

for i=1:39
    t(i)=bitxor(a11(i),b11(i));
    k1(i)=bitxor(c11(i),t(i));
end
k1(1,40)=bitxor(k1(1,38),k1(1,39));
t1=circshift(k1',20);
z=t1';

% encryption step 4

for p=1:10
    
    w1=eg(1:100,1:100,1:3);
w2=eg(101:200,1:100,1:3);
w3=eg(1:100,101:200,1:3);
w4=eg(101:200,101:200,1:3);
eg=[w4 w2;w3 w1];
for i=1:200
    for j=1:200
        for k=1:3
            if(mod(p,2)==0)
            
            if(j==1||l==1)
            c22(i,j,k)=bitxor(eg(i,j,k),k1(l));
            eg(i,j,k)=c22(i,j,k);
            else
            c22(i,j,k)=bitxor(eg(i,j-1,k),eg(i,j,k));
            eg(i,j,k)=bitxor(k1(l),c22(i,j,k));
            end
           
            else
                if(j==1||l==1)
            c22(i,j,k)=bitxor(eg(i,j,k),z(l));
            eg(i,j,k)=c22(i,j,k);
            else
            c22(i,j,k)=bitxor(eg(i,j-1,k),eg(i,j,k));
            eg(i,j,k)=bitxor(z(l),c22(i,j,k));
                end
            end

        end
             l=l+1;
 if(l>40)
     l=1;
 end
      
    end
end
end
axes(handles.axes4)
imshow(eg)
img2=eg;
img33=eg;

function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double

global key;
key=str2num(get(handles.edit3,'String'));



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


global key2;
key2=str2num(get(handles.edit5,'String'));


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dcry;
global key;

t1=dcry(1:200,1:20,1:3);
t2=dcry(1:200,21:40,1:3);
t3=dcry(1:200,41:60,1:3);
t4=dcry(1:200,61:80,1:3);
t5=dcry(1:200,81:100,1:3);
t6=dcry(1:200,101:120,1:3);
t7=dcry(1:200,121:140,1:3);
t8=dcry(1:200,141:160,1:3);
t9=dcry(1:200,161:180,1:3);
t10=dcry(1:200,181:200,1:3);
% Dividing image into 8 vertical blocks %
dg1=[t4 t6 t1 t3 t2 t5 t8 t7 t10 t9];
% Rearranging to get the original sequence %

y1=dg1(1:20,1:200,1:3);
y2=dg1(21:40,1:200,1:3);
y3=dg1(41:60,1:200,1:3);
y4=dg1(61:80,1:200,1:3);
y5=dg1(81:100,1:200,1:3);
y6=dg1(101:120,1:200,1:3);
y7=dg1(121:140,1:200,1:3);
y8=dg1(141:160,1:200,1:3);
y9=dg1(161:180,1:200,1:3);
y10=dg1(181:200,1:200,1:3);
% Dividing image into 8 horizontal blocks %
dg=[y4;y6;y1;y3;y2;y5;y8;y7;y10;y9];
% Rearranging to get the decrypted image %

% 2 stage decrption : Decryption from pixel manupulation %

m=1;
x=1;
l=1;
for i=1:200
    for j=1:200
        for k=1:3
            b1(i,key(l),k)=dg(i,j,k);
            % Transferring 8 pixels in original order from encrypted image
            % dg to new matrix b1
        end
        
        l=l+1;
        if(l>8)
            for n=1:8
                for m=1:3
                    e2(i,x,m)=b1(i,n,m);
                    % Storing the original pixel combinations in new matrix
                    % e2
                end
                x=x+1;
            end
            l=1;
        else
        end
    end
    x=1;
end

 
% 3 stage decryption : Decryption from bit manupulation %

e3=double(e2);
% Converting to indexed image %

for i=1:200
    for j=1:200
        for k=1:3
            b2=dec2bin(e3(i,j,k),8);
            % Converting each pixel value from decimal to binary and inserting zeroes to make it 8 bits % 
            
            for l=1:8
                c1(key(l))=b2(l);
                % Rearranging the bits to obtain original pixel values %
            end
            e4(i,j,k)=bin2dec(c1);
            % Reinserting the rearranged bits to obtain fully decrypted
            % image e4
        end
    end
end
decryimg=uint8(e4-1);

axes(handles.axes6)
imshow(decryimg);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global key2;
global img1;

l1=2;
q1=1;
l2=15;
q2=14;
l3=28;
q3=27;

k11=zeros(1,40);

for i=1:39

if(mod(i,4)==0)
q1=q1+1;
l1=q1+1;

q2=q2+1;
l2=q2+1;

q3=q3+1;
l3=q3+1;
end

a1(i)=bitxor(key2(q1),key2(l1));
l1=l1+1;
a(i)=bitxor(a1(i),key2(l1));

b1(i)=bitxor(key2(q2),key2(l2));
l2=l2+1;
b(i)=bitxor(b1(i),key2(l2));

c1(i)=bitxor(key2(q3),key2(l3));
l3=l3+1;
c(i)=bitxor(c1(i),key2(l3));

end

for i=1:39
    t(i)=bitxor(a1(i),b1(i));
    k11(i)=bitxor(c1(i),t(i));
end
k11(1,40)=bitxor(k11(1,38),k11(1,39));
t1=circshift(k11',20);
z=t1';

l=40;
for p=10:-1:1
    if(p<10)
    w1=img1(1:100,1:100,1:3);
w2=img1(101:200,1:100,1:3);
w3=img1(1:100,101:200,1:3);
w4=img1(101:200,101:200,1:3);
img1=[w4 w2;w3 w1];
    end
for i=200:-1:1
   for j=200:-1:1
        for k=1:3
            if(mod(p,2)==0)
           
            if(j==1||l==1)
                o(i,j,k)=bitxor(img1(i,j,k),k11(l));
                img1(i,j,k)=o(i,j,k);
            else
            y(i,j,k)=bitxor(img1(i,j,k),k11(l));
            img1(i,j,k)=bitxor(y(i,j,k),img1(i,j-1,k));
            end
            
            else
                if(j==1||l==1)
                o(i,j,k)=bitxor(img1(i,j,k),z(l));
                img1(i,j,k)=o(i,j,k);
            else
            y(i,j,k)=bitxor(img1(i,j,k),z(l));
            img1(i,j,k)=bitxor(y(i,j,k),img1(i,j-1,k));
            
                end
            end
        end
       l=l-1;
       if(l<1)
           l=40;
       end
   end
end
end
w1=img1(1:100,1:100,1:3);
w2=img1(101:200,1:100,1:3);
w3=img1(1:100,101:200,1:3);
w4=img1(101:200,101:200,1:3);
img1=[w4 w2;w3 w1];

axes(handles.axes7)
imshow(img1);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global key;
global key2;
global img2;

l1=2;
q1=1;
l2=15;
q2=14;
l3=28;
q3=27;

k22=zeros(1,40);

for i=1:39

if(mod(i,4)==0)
q1=q1+1;
l1=q1+1;

q2=q2+1;
l2=q2+1;

q3=q3+1;
l3=q3+1;
end

a1(i)=bitxor(key2(q1),key2(l1));
l1=l1+1;
a(i)=bitxor(a1(i),key2(l1));

b1(i)=bitxor(key2(q2),key2(l2));
l2=l2+1;
b(i)=bitxor(b1(i),key2(l2));

c1(i)=bitxor(key2(q3),key2(l3));
l3=l3+1;
c(i)=bitxor(c1(i),key2(l3));

end

for i=1:39
    t(i)=bitxor(a1(i),b1(i));
    k22(i)=bitxor(c1(i),t(i));
end
k22(1,40)=bitxor(k22(1,38),k22(1,39));
t1=circshift(k22',20);
z=t1';



l=40;
for p=10:-1:1
    if(p<10)
    w1=img2(1:100,1:100,1:3);
w2=img2(101:200,1:100,1:3);
w3=img2(1:100,101:200,1:3);
w4=img2(101:200,101:200,1:3);
img2=[w4 w2;w3 w1];
    end
for i=200:-1:1
   for j=200:-1:1
        for k=1:3
            if(mod(p,2)==0)
           
            if(j==1||l==1)
                o(i,j,k)=bitxor(img2(i,j,k),k22(l));
                img2(i,j,k)=o(i,j,k);
            else
            y(i,j,k)=bitxor(img2(i,j,k),k22(l));
            img2(i,j,k)=bitxor(y(i,j,k),img2(i,j-1,k));
            end
            
            else
                if(j==1||l==1)
                o(i,j,k)=bitxor(img2(i,j,k),z(l));
                img2(i,j,k)=o(i,j,k);
            else
            y(i,j,k)=bitxor(img2(i,j,k),z(l));
            img2(i,j,k)=bitxor(y(i,j,k),img2(i,j-1,k));
            
                end
            end
        end
       l=l-1;
       if(l<1)
           l=40;
       end
   end
end
end
w1=img2(1:100,1:100,1:3);
w2=img2(101:200,1:100,1:3);
w3=img2(1:100,101:200,1:3);
w4=img2(101:200,101:200,1:3);
img2=[w4 w2;w3 w1];


% Decryption %

% 1 stage : Decryption from block manupulation %



t1=img2(1:200,1:20,1:3);
t2=img2(1:200,21:40,1:3);
t3=img2(1:200,41:60,1:3);
t4=img2(1:200,61:80,1:3);
t5=img2(1:200,81:100,1:3);
t6=img2(1:200,101:120,1:3);
t7=img2(1:200,121:140,1:3);
t8=img2(1:200,141:160,1:3);
t9=img2(1:200,161:180,1:3);
t10=img2(1:200,181:200,1:3);
% Dividing image into 8 vertical blocks %
dg1=[t4 t6 t1 t3 t2 t5 t8 t7 t10 t9];
% Rearranging to get the original sequence %

y1=dg1(1:20,1:200,1:3);
y2=dg1(21:40,1:200,1:3);
y3=dg1(41:60,1:200,1:3);
y4=dg1(61:80,1:200,1:3);
y5=dg1(81:100,1:200,1:3);
y6=dg1(101:120,1:200,1:3);
y7=dg1(121:140,1:200,1:3);
y8=dg1(141:160,1:200,1:3);
y9=dg1(161:180,1:200,1:3);
y10=dg1(181:200,1:200,1:3);
% Dividing image into 8 horizontal blocks %
dg=[y4;y6;y1;y3;y2;y5;y8;y7;y10;y9];
% Rearranging to get the decrypted image %

% 2 stage decrption : Decryption from pixel manupulation %

m=1;
x=1;
l=1;
for i=1:200
    for j=1:200
        for k=1:3
            b1(i,key(l),k)=dg(i,j,k);
            % Transferring 8 pixels in original order from encrypted image
            % dg to new matrix b1
        end
        
        l=l+1;
        if(l>8)
            for n=1:8
                for m=1:3
                    e2(i,x,m)=b1(i,n,m);
                    % Storing the original pixel combinations in new matrix
                    % e2
                end
                x=x+1;
            end
            l=1;
        else
        end
    end
    x=1;
end

 
% 3 stage decryption : Decryption from bit manupulation %

e3=double(e2);
% Converting to indexed image %

for i=1:200
    for j=1:200
        for k=1:3
            b2=dec2bin(e3(i,j,k),8);
            % Converting each pixel value from decimal to binary and inserting zeroes to make it 8 bits % 
            
            for l=1:8
                c11(key(l))=b2(l);
                % Rearranging the bits to obtain original pixel values %
            end
            e4(i,j,k)=bin2dec(c11);
            % Reinserting the rearranged bits to obtain fully decrypted
            % image e4
        end
    end
end
decryimg=uint8(e4-1);
axes(handles.axes8)
imshow(decryimg);


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global main;
global dcry;

figure;
subplot(2,3,1)
imhist(main(:,:,1),256);
subplot(2,3,2)
imhist(main(:,:,2),256);
subplot(2,3,3)
imhist(main(:,:,3),256);
subplot(2,3,4)
imhist(dcry(:,:,1),256);
subplot(2,3,5)
imhist(dcry(:,:,2),256);
subplot(2,3,6)
imhist(dcry(:,:,3),256);


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global main;
global img22;

figure;
subplot(2,3,1)
imhist(main(:,:,1),256);
subplot(2,3,2)
imhist(main(:,:,2),256);
subplot(2,3,3)
imhist(main(:,:,3),256);
subplot(2,3,4)
imhist(img22(:,:,1),256);
subplot(2,3,5)
imhist(img22(:,:,2),256);
subplot(2,3,6)
imhist(img22(:,:,3),256);

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global main;
global img33;


figure;
subplot(2,3,1)
imhist(main(:,:,1),256);
subplot(2,3,2)
imhist(main(:,:,2),256);
subplot(2,3,3)
imhist(main(:,:,3),256);
subplot(2,3,4)
imhist(img33(:,:,1),256);
subplot(2,3,5)
imhist(img33(:,:,2),256);
subplot(2,3,6)
imhist(img33(:,:,3),256);


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global main;
global dcry;

r1=main(:,:,1);
b1=main(:,:,2);
g1=main(:,:,3);
r2=dcry(:,:,1);
b2=dcry(:,:,2);
g2=dcry(:,:,3);

l=1;
for i=1:200
    for j=1:200
        t1(l)=r1(i,j);
        t2(l)=b1(i,j);
        t3(l)=g1(i,j);
        t4(l)=r2(i,j);
        t5(l)=b2(i,j);
        t6(l)=g2(i,j);
        l=l+1;
    end
end

for i=1:39999
    y1(i+1)=t1(i);
    y2(i+1)=t2(i);
    y3(i+1)=t3(i);
    y4(i+1)=t4(i);
    y5(i+1)=t5(i);
    y6(i+1)=t6(i);
    q5(i+1)=i;
end

figure;
subplot(2,3,1)
stem3(t1,y1,q5);
subplot(2,3,2)
stem3(t2,y2,q5);
subplot(2,3,3)
stem3(t3,y3,q5);
subplot(2,3,4)
stem3(t4,y4,q5);
subplot(2,3,5)
stem3(t5,y5,q5);
subplot(2,3,6)
stem3(t6,y6,q5);



% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global main;
global img22;

r1=main(:,:,1);
b1=main(:,:,2);
g1=main(:,:,3);
r2=img22(:,:,1);
b2=img22(:,:,2);
g2=img22(:,:,3);

l=1;
for i=1:200
    for j=1:200
        t1(l)=r1(i,j);
        t2(l)=b1(i,j);
        t3(l)=g1(i,j);
        t4(l)=r2(i,j);
        t5(l)=b2(i,j);
        t6(l)=g2(i,j);
        l=l+1;
    end
end

for i=1:39999
    y1(i+1)=t1(i);
    y2(i+1)=t2(i);
    y3(i+1)=t3(i);
    y4(i+1)=t4(i);
    y5(i+1)=t5(i);
    y6(i+1)=t6(i);
    q5(i+1)=i;
end

figure;
subplot(2,3,1)
stem3(t1,y1,q5);
subplot(2,3,2)
stem3(t2,y2,q5);
subplot(2,3,3)
stem3(t3,y3,q5);
subplot(2,3,4)
stem3(t4,y4,q5);
subplot(2,3,5)
stem3(t5,y5,q5);
subplot(2,3,6)
stem3(t6,y6,q5);



% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global main;
global img33;

r1=main(:,:,1);
b1=main(:,:,2);
g1=main(:,:,3);
r2=img33(:,:,1);
b2=img33(:,:,2);
g2=img33(:,:,3);

l=1;
for i=1:200
    for j=1:200
        t1(l)=r1(i,j);
        t2(l)=b1(i,j);
        t3(l)=g1(i,j);
        t4(l)=r2(i,j);
        t5(l)=b2(i,j);
        t6(l)=g2(i,j);
        l=l+1;
    end
end

for i=1:39999
    y1(i+1)=t1(i);
    y2(i+1)=t2(i);
    y3(i+1)=t3(i);
    y4(i+1)=t4(i);
    y5(i+1)=t5(i);
    y6(i+1)=t6(i);
    q5(i+1)=i;
end

figure;
subplot(2,3,1)
stem3(t1,y1,q5);
subplot(2,3,2)
stem3(t2,y2,q5);
subplot(2,3,3)
stem3(t3,y3,q5);
subplot(2,3,4)
stem3(t4,y4,q5);
subplot(2,3,5)
stem3(t5,y5,q5);
subplot(2,3,6)
stem3(t6,y6,q5);
