function [ final_map,ini_lummap,all_map,local_map] = sky_detect(I,I_gra)
%ini_lummap是最初的亮度二值图（局部与全局）
%final_map是最终的完全是天空区域的部分
    lradius=9;
    L = mean(I,3);
    [H,W]=size(L);
    
    avaL=sum(sum(L))/(H*W);
    lum_map=zeros(H,W);
    all_map=zeros(H,W);
    local_map=zeros(H,W);
    L_lum=padarray(L,[lradius lradius],'replicate');
    for k=1+lradius:H+lradius
        for j=1+lradius:W+lradius
            patch=L_lum((k-lradius):(k+lradius),(j-lradius):(j+lradius));
            lum_map(k-lradius,j-lradius)=sum(sum(patch))/((2*lradius+1)*(2*lradius+1));
        end
    end
        %对于无视区域的0-1判断图进行计算lum_map
        lum_map=lum_map-L;
        avalum_map=L-avaL;       
        %周围平均亮度比当前像素值大
        local_map(lum_map>0)=0;
        all_map(avalum_map>=0)=1;
        %周围平均亮度比当前像素值小
        local_map(lum_map<=0)=1;
        local_map(abs(lum_map)<1.0e-9)=1;      
        all_map(avalum_map<0)=0;
        %lummap保存中间结果
        lum_map=all_map.*local_map;
        ini_lummap=lum_map;
        
        %imwrite(lum_map,[path_save,imageName(1:end-4),'_alum_map=',num2str(i),'_type=0','.bmp']);
        %选择全局中最大的连通区域        
        imLabel = bwlabel(lum_map,8);                %对各连通域进行标记  
        stats = regionprops(imLabel,'Area');    %求各连通域的大小  
        area = cat(1,stats.Area);  
        index = find(area == max(area));        %求最大连通域的索引  
        temp_map = ismember(imLabel,index);          %获取最大连通域图像 
        %imwrite(temp_map,[path_save,imageName(1:end-4),'_connect_map=',num2str(i),'_type=1','.bmp']);       
        %反选最大的连通区域
        temp_map=double(temp_map);
        temp_map=1-temp_map;
        lum_map=temp_map;
        imLabel = bwlabel(lum_map,4);                %对各连通域进行标记  
        stats = regionprops(imLabel,'Area');    %求各连通域的大小  
        area = cat(1,stats.Area);  
        index = find(area == max(area));        %求最大连通域的索引  
        temp_map = ismember(imLabel,index);          %获取最大连通域图像 
        %imwrite(temp_map,[path_save,imageName(1:end-4),'_connect_map=',num2str(i),'_type=2','.bmp']);
        
        %判断连通区域中黑色所占比例
        temp_map=1-temp_map;
        %imwrite(temp_map,[path_save,imageName(1:end-4),'_connect_map=',num2str(i),'_type=3','.bmp']);
        num1=sum(sum(temp_map.*lum_map))/sum(sum(temp_map));
       
        temp_lummap=zeros(H,W);
        if(num1>=0.4&&num1<=0.6)
            num2=sum(sum(temp_map.*I_gra))/sum(sum(temp_map));
            dark_tempmap=temp_map;
            %imwrite(temp_map,[path_save,imageName(1:end-4),'_connect_map=',num2str(i),'num1=',num2str(num1),'num2=',num2str(num2),'_type=3','.bmp']);
            if(num2<=0.2)
               temp_map=temp_map.*I_gra;
               %imwrite(temp_map,[path_save,imageName(1:end-4),'_templum_map=1','_type=0','.bmp']);
               temp_lummap((temp_map>=0)&(temp_map<=num2))=1;
               temp_lummap(dark_tempmap==0)=0;
               temp_map=temp_lummap;
            else
                temp_map(:,:)=0;
            end        
        else
        temp_map(:,:)=0;
        end    
        temp_map=bwareaopen(temp_map,25*25,4);
        %根据梯度得到天空的准确区域    
        temp_map=1-temp_map;
        temp_map=bwareaopen(temp_map,75*75,4);
        temp_map=1-temp_map;         
        final_map=temp_map;
end

