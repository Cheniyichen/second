function main
% ������ͼ����
h=figure('NumberTitle', 'off', 'Name', '��ռ��������');
set(h,'position',[100 100 1000 600]);
 axes('units','normal','pos',[.1 .3 .8 .6]);
 uicontrol('style','push','units','normal','pos',[.4 .1 .2 .1],'str','ѡ��ͼ��������������','call',@localOpenPic)

function localOpenPic(varargin)% ��ť�Ļص�����

filter = { ...
        '*.bmp;*.jpg;*.gif;*.emf', '����ͼ���ļ� (*.bmp; *.jpg; *.gif; *emf)'; ...
        '*.bmp',  'λͼ�ļ� (*.bmp)'; ...
        '*.jpg', 'JPEG�ļ� (*.jpg)'; ...
        '*.gif', 'GIF�ļ� (*.gif)'; ...
        '*.emf', 'ͼԪ�ļ� (*.emf)'; ...
        '*.*',  '�����ļ� (*.*)' ...
    };

% ѡ���ļ�
[filename, pathname] = uigetfile( filter, '��...');
if isequal(filename,0) | isequal(pathname,0), return, end

% ����ͼ����ʾ
[X, map] = imread([pathname filename]);
colormap(map)
imshow(X);
%��������
J=im2double(X);
sky=Norm(J);
figure('NumberTitle', 'off', 'Name', '����ͼ����ռ����');
imshow(sky);

