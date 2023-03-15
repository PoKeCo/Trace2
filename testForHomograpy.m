%tiledlayout(2,1,"TileSpacing","none");
clf;


imgOrg=imread('crop.png');

sy=240;
imgOrg=imgOrg(sy:end,:,:);
imgOrg(1:end,1:10:end,:)=0;
imgOrg(1:10:end,1:end,:)=0;

%nexttile(1);
figure(1);
imshow(imgOrg);
hold off;
imgOrgSize=size(imgOrg);
hold on;

% orgPos=[...
%     108,810;
%     402,415;
%     509,259;
%     1088,810;
%     720,415;
%     574,250];
orgPos=[...
    318,536;    
    514,252+2;
    825,531;    
    575,252]-[0,sy-1];

dstPos=[...
     0.01 ,0.01;
    25.36 ,0.01;
     0.01 ,3.0;
    25.36 ,3.0];

H=estimateHomography(orgPos,dstPos);
rng=autoRange(dstPos);
iRefSize=[480,round(480*(rng(2)-rng(1))/(rng(4)-rng(3))),3];
%H=estimateHomography(dstPos,orgPos);
%tform=projective2d(H');
%I_ref = imref2d(imgOrgSize);

I_ref=imref2d(iRefSize,rng(1:2),rng(3:4));

[tform] = projective2d(H');

[dstImg,BR]=imwarp(imgOrg,tform,"OutputView",I_ref);

plot(orgPos(:,1),orgPos(:,2),'.-r');


%nexttile(2);
figure(2);
hold off;
imshow(dstImg,BR);
hold on;
axis equal;
axis (rng);
axis ij;
plot(dstPos(:,1),dstPos(:,2));


function [rng]=autoRange(pos)
    margineX=1;
    margineY=1;
    sx=min(pos(:,1))-margineX;
    ex=max(pos(:,1))+margineX;
    sy=min(pos(:,2))-margineY;
    ey=max(pos(:,2))+margineY;
    rng=[sx,ex,sy,ey];
end
