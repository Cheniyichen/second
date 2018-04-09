function [I_gra] = gra( I )
    [height,width,~]=size(I);
    I_r = I(:,:,1);
    I_g = I(:,:,2);
    I_b = I(:,:,3);

    I_r_gra = imgradient(I_r,'sobel');
    I_g_gra = imgradient(I_g,'sobel');
    I_b_gra = imgradient(I_b,'sobel');
    I_gra = sqrt(I_r_gra.^2+I_g_gra.^2+I_b_gra.^2);
   
    I_gra_sort = I_gra(:);
    I_gra_sort = sort(I_gra_sort);
    I_gra_newmax=  I_gra_sort(round(height*width*0.9)); 
    I_gra(I_gra>I_gra_newmax) = I_gra_newmax;
%     I_gra1=I_gra;
    I_gra = I_gra./I_gra_newmax;
end

