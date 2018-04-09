function [sky_map ] = likearea( finalmap,J)
    [m,n,~]=size(J);
    J_R=J(:,:,1);
    J_G=J(:,:,2);
    J_B=J(:,:,3);
    
    ava_r=sum(sum(J_R.*finalmap))/sum(sum(finalmap));
    ava_g=sum(sum(J_G.*finalmap))/sum(sum(finalmap));
    ava_b=sum(sum(J_B.*finalmap))/sum(sum(finalmap));
    
    J_R=abs(J_R-ava_r);
    J_G=abs(J_G-ava_g);
    J_B=abs(J_B-ava_b);
    
    temp_map=zeros(m,n);
    lum_map=J_R.*J_R+J_G.*J_G+J_B.*J_B;
    lum_map=sqrt(lum_map);
    temp_map(lum_map<0.13)=1;
%     imwrite(temp_map,[path_save,imageName(1:end-4),'_likemap','_type=0','.bmp']);
    temp_map=bwareaopen(temp_map,5*5,4);
     sky_map=zeros(m,n);
     sky_map(temp_map==1)=1;
     sky_map(finalmap==1)=1;

end

