function [sky_map] = Norm(I)
      
      [I_gra]=gra(I);
      [final_map,lum_map]=sky_detect(I,I_gra);
      sky_map=likearea(final_map,I);   
%       sky_map=zeros(m,n);
%      sky_map(temp_map==1)=1;
%      sky_map(final_map==1)=1;
%      lum_map(sky_map==1)=1;
     
%      imwrite(sky_map,[path_save_1,imageName(1:end-4),'_skymap=',num2str(i),'Ìì¿Õ','.bmp']); 
end

