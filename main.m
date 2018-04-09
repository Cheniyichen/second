function main
% 创建绘图窗口
h=figure('NumberTitle', 'off', 'Name', '天空检测主窗口');
set(h,'position',[100 100 1000 600]);
 axes('units','normal','pos',[.1 .3 .8 .6]);
 uicontrol('style','push','units','normal','pos',[.4 .1 .2 .1],'str','选择图像进行天空区域检测','call',@localOpenPic)

function localOpenPic(varargin)% 按钮的回调函数

filter = { ...
        '*.bmp;*.jpg;*.gif;*.emf', '所有图像文件 (*.bmp; *.jpg; *.gif; *emf)'; ...
        '*.bmp',  '位图文件 (*.bmp)'; ...
        '*.jpg', 'JPEG文件 (*.jpg)'; ...
        '*.gif', 'GIF文件 (*.gif)'; ...
        '*.emf', '图元文件 (*.emf)'; ...
        '*.*',  '所有文件 (*.*)' ...
    };

% 选择文件
[filename, pathname] = uigetfile( filter, '打开...');
if isequal(filename,0) | isequal(pathname,0), return, end

% 读入图像并显示
[X, map] = imread([pathname filename]);
colormap(map)
imshow(X);
%函数主体
J=im2double(X);
sky=Norm(J);
figure('NumberTitle', 'off', 'Name', '有雾图像天空检测结果');
imshow(sky);

